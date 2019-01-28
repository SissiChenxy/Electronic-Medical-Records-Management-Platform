package com.me.EMR.controller;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.me.EMR.dao.AppointmentDAO;
import com.me.EMR.dao.MessageDAO;
import com.me.EMR.dao.UserDAO;
import com.me.EMR.pojo.Appointment;
import com.me.EMR.pojo.Doctor;
import com.me.EMR.pojo.Message;
import com.me.EMR.pojo.Patient;
import com.me.EMR.pojo.User;



@Controller
public class MessageAndAppointmentController {

	@RequestMapping(value = "/messages.htm", method = RequestMethod.GET)
	public String showMessagePage(HttpServletRequest request, MessageDAO messageDao, UserDAO userDao, ModelMap map) {
		HttpSession session = request.getSession();
		User currentUser = (User) session.getAttribute("user");
		String action = request.getParameter("action");
		if (action.equals("inbox")) {
			int receiverid = currentUser.getAccountid();
			List<Message> messageList = messageDao.getByReceiver(receiverid);
			map.addAttribute("messageList", messageList);
			return "messages-inbox";
		} else if (action.equals("compose")) {
			map.addAttribute("sender", currentUser);
			String reply = request.getParameter("reply");
			if (reply == null) {
				return "messages-compose";
			} else if (reply.equals("yes")) {
				map.addAttribute("replySender", currentUser);
				int receiverid = Integer.parseInt(request.getParameter("replyReceiver"));
				String subject = request.getParameter("subject");
				User receiver = userDao.get(receiverid);
				map.addAttribute("replyReceiver", receiver);
				map.addAttribute("reply", "yes");
				map.addAttribute("subject", subject);
				return "messages-compose";
			}
		} else if (action.equals("reply")) {
			return "messages-inbox";
		} else if(action.equals("delete")) {
		    int messageid = Integer.parseInt(request.getParameter("messageid"));
		    messageDao.delete(messageid);
		    return "redirect:/messages.htm?action=inbox";
		}
		return null;
	}

	@RequestMapping(value = "/messages.htm", method = RequestMethod.POST)
	public String handleMessagesRequests(@RequestParam("attachedfile") MultipartFile file, HttpServletRequest request,
			UserDAO userDao, MessageDAO messageDao, ModelMap map) throws Exception {
		String action = request.getParameter("action");
		if (action.equals("compose")) {
			HttpSession session = request.getSession();
			int receiverid = Integer.parseInt(request.getParameter("receiver"));
			String subject = request.getParameter("subject");
			String content = request.getParameter("content");
			String replyFlag = request.getParameter("replyFlag");

			Message message = new Message();
			message.setSubject(subject);
			User receiver = userDao.get(receiverid);
			User sender = (User) session.getAttribute("user");
			message.setSender(sender);
			message.setReceiver(receiver);
			message.setContent(content);
			// 判断这个文件不为空
			if (!file.isEmpty()) {
				// 服务端的images目录需要手动创建好,上传到服务器目录下
				// String path = session.getServletContext().getRealPath("/images");
				String path = "/Users/chenxinyun/Google Drive/NEU/6250/final-project-6250";
				// 获取原始文件名
				String fileName = file.getOriginalFilename();
				// 截取文件的扩展名
				String extName = fileName.substring(fileName.lastIndexOf("."));
				File myFile = new File(path, fileName);
				// 完成文件上传
				file.transferTo(myFile);

				message.setAttachedfile(fileName);
			}
			messageDao.create(message);
			if (replyFlag == null) {
				return "redirect:/messages.htm?action=inbox";
			}
			if (replyFlag.equals("finished")) {
				String text = "You have successfully replied to " + receiver.getUsername();
				map.addAttribute("content", text);
				return "success";
			}
		}
		return null;
	}

	@RequestMapping(value = "/message/downloadFile.htm", method = RequestMethod.GET)
	public ResponseEntity<byte[]> downloadAssignment(HttpServletRequest request,
			@RequestParam("filename") String filename, ModelMap model) throws Exception {

		String path = "/Users/chenxinyun/Google Drive/NEU/6250/final-project-6250";
		File file = new File(path + File.separator + filename);
		HttpHeaders headers = new HttpHeaders();
		// 下载显示的文件名，解决中文名称乱码问题
		String downloadFileName = new String(filename.getBytes("UTF-8"), "iso-8859-1");
		// 通知浏览器以attachment（下载方式）打开图片
		headers.setContentDispositionFormData("attachment", downloadFileName);
		// application/octet-stream ： 二进制流数据（最常见的文件下载）。
		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
		return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file), headers, HttpStatus.CREATED);
	}

	@RequestMapping(value = "/appointments.htm", method = RequestMethod.GET)
	public String showAppointmentPage(HttpServletRequest request, UserDAO userDao, AppointmentDAO appointmentDao,
			ModelMap map) throws Exception {
		HttpSession session = request.getSession();
		User currentUser = (User) session.getAttribute("user");
		String action = request.getParameter("action");
		if (action.equals("view")) {
			int receiverid = currentUser.getAccountid();
			List<Appointment> appointmentList = appointmentDao.getByReceiverId(receiverid);
			map.addAttribute("appointmentList", appointmentList);
			return "appointments-view";
		} else if (action.equals("request")) {
			map.addAttribute("sender", currentUser);
			String edit = request.getParameter("edit");
			    if (edit == null) {
				return "appointments-request";
			} else if (edit.equals("yes")) {
				map.addAttribute("replySender", currentUser);
				int receiverid = Integer.parseInt(request.getParameter("replyReceiver"));
				String visitReason = request.getParameter("visitReason");
				User receiver = userDao.get(receiverid);
				map.addAttribute("replyReceiver", receiver);
				map.addAttribute("edit", "yes");
				map.addAttribute("visitReason", visitReason);
				return "appointments-request";
			}
		}else if(action.equals("confirmed")) {
			String appointmentid = request.getParameter("appointmentid");
			System.out.println("here" + appointmentid);
			Appointment appointment = appointmentDao.getById(appointmentid);
			String confirmedTimes = request.getAttribute("startDate") + "-" +request.getAttribute("endDate")+ "-" +request.getAttribute("startTime")+ "-" +request.getAttribute("endTime");
			appointment.setConfirmedTimes(confirmedTimes);
			appointmentDao.confirmTime(appointmentid, confirmedTimes, "confirmed");
			return "redirect:/appointments.htm?action=view";
		}if(action.equals("cancel")) {
			String appointmentid = request.getParameter("appointmentid");
			appointmentDao.cancel(appointmentid);
			return "redirect:/appointments.htm?action=view";
		}
		return null;
	}
	
	@RequestMapping(value = "/appointments.htm", method = RequestMethod.POST)
	public String handleAppointmentsRequests(HttpServletRequest request, UserDAO userDao, AppointmentDAO appointmentDao,
			ModelMap map) throws Exception {
		String action = request.getParameter("action");
		if (action.equals("request")) {
			HttpSession session = request.getSession();
			int receiverid = Integer.parseInt(request.getParameter("receiver"));
			String visitReason = request.getParameter("visitReason");
			String startDate = request.getParameter("startDate");
			String endDate = request.getParameter("endDate");
			String startTime = request.getParameter("startTime");
			String endTime = request.getParameter("endTime");
			String editFlag = request.getParameter("editFlag");

			Appointment appointment = new Appointment();
			String status = request.getParameter("status");
			String accountid = request.getParameter("senderStatusId");
			User u = userDao.get(Integer.parseInt(accountid));
			if(u instanceof Patient) {
				appointment.setStatus("send to doctor");
			}else if(u instanceof Doctor) {
				appointment.setStatus("send to patient");
			}
	
			User receiver = userDao.get(receiverid);
			User sender = (User) session.getAttribute("user");
			appointment.setSender(sender);
			appointment.setReceiver(receiver);
			appointment.setVisitReason(visitReason);
			appointment.setPreferredDateBegin(startDate);
			appointment.setPreferredDateEnd(endDate);
			appointment.setPreferredTimeBegin(startTime);
			appointment.setPreferredTimeEnd(endTime);
			appointmentDao.create(appointment);	
			if (editFlag == null) {
				return "redirect:/appointments.htm?action=view";
			} else if (editFlag.equals("finished")) {
				String text = "You have successfully edited the appointment with " + receiver.getUsername();
				map.addAttribute("content", text);
				return "success";
			}
		}
		return null;
	}

	@RequestMapping(value = "/patient/testresults.htm", method = RequestMethod.GET)
	public String showTestResultsPage(HttpServletRequest request, UserDAO userDao, ModelMap map) {
		HttpSession session = request.getSession();
		User currentUser = (User) session.getAttribute("user");
		String action = request.getParameter("action");
		if (action.equals("inbox")) {
			return "patient-testresults";
		}
		return null;
	}

}
