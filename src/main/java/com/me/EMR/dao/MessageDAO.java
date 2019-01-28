package com.me.EMR.dao;

import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import com.me.EMR.pojo.Message;

public class MessageDAO extends DAO {
	
	public List<Message> getByReceiver(int receiverid) {
		try {
			begin();
			Query q = getSession().createQuery("from Message where receiver = :receiver");
			q.setInteger("receiver", receiverid);
			List<Message> messages = q.list();
			close();
			return messages;
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return null;
	}
	
	public Message create(Message message) throws Exception{
		try {
			begin();
			System.out.println("inside DAO");
			getSession().save(message);
			commit();
			return message;
		}catch(HibernateException e) {
			rollback();
			throw new Exception("Exception while creating message: " + e.getMessage());
		}
	}
	
	public boolean update(String id,String subject,String attachedfile,String content) throws Exception{
		try {
			begin();
			System.out.println("inside DAO");
			Query q = getSession().createQuery("from Message where messageid = : id");
			q.setString("id", id);
			Message message = (Message)q.uniqueResult();
			if(message != null) {
				message.setSubject(subject);
				message.setAttachedfile(attachedfile);
				message.setContent(content);
				getSession().update(message);
				commit();
				return true;
			}else {
				return false;
			}
		}catch(HibernateException e) {
			rollback();
			throw new Exception("Exception while editing appointment :" + e.getMessage());
		}
	}
	
	public boolean delete(int messageid) {
		try {
			begin();
			Query q = getSession().createQuery("delete from Message where messageid = :messageid");
			q.setInteger("messageid", messageid);
			q.executeUpdate();
			close();
			return true;
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return false;
	}
	
}
