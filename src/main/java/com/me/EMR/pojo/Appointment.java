package com.me.EMR.pojo;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity
public class Appointment {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="appointmentid", unique = true, nullable = false)
	private String appointmentid;
	
	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name="sender")
	private User sender;
	
	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name="receiver")
	private User receiver;
	
	@Column(name="visitReason")
	private String visitReason;
	
	@Column(name="preferredDateBegin")
	private String preferredDateBegin;
	
	@Column(name="preferredDateEnd")
	private String preferredDateEnd;
	
	@Column(name="preferredTimeBegin")
	private String preferredTimeBegin;
	
	@Column(name="preferredTimeEnd")
	private String preferredTimeEnd;
	
	@Column(name="confirmedTimes")
	private String confirmedTimes;
	
	@Column(name="status")
	private String status;

	public Appointment() {
		super();
	}

	public String getAppointmentid() {
		return appointmentid;
	}

	public void setAppointmentid(String appointmentid) {
		this.appointmentid = appointmentid;
	}

	public User getSender() {
		return sender;
	}

	public void setSender(User sender) {
		this.sender = sender;
	}

	public User getReceiver() {
		return receiver;
	}

	public void setReceiver(User receiver) {
		this.receiver = receiver;
	}

	public String getVisitReason() {
		return visitReason;
	}

	public void setVisitReason(String visitReason) {
		this.visitReason = visitReason;
	}

	public String getPreferredDateBegin() {
		return preferredDateBegin;
	}

	public void setPreferredDateBegin(String preferredDateBegin) {
		this.preferredDateBegin = preferredDateBegin;
	}

	public String getPreferredDateEnd() {
		return preferredDateEnd;
	}

	public void setPreferredDateEnd(String preferredDateEnd) {
		this.preferredDateEnd = preferredDateEnd;
	}

	public String getPreferredTimeBegin() {
		return preferredTimeBegin;
	}

	public void setPreferredTimeBegin(String preferredTimeBegin) {
		this.preferredTimeBegin = preferredTimeBegin;
	}

	public String getPreferredTimeEnd() {
		return preferredTimeEnd;
	}

	public void setPreferredTimeEnd(String preferredTimeEnd) {
		this.preferredTimeEnd = preferredTimeEnd;
	}

	public String getConfirmedTimes() {
		return confirmedTimes;
	}

	public void setConfirmedTimes(String confirmedTimes) {
		this.confirmedTimes = confirmedTimes;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

}
