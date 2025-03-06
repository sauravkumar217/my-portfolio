package com.saurav.service;

import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailService {

    private final JavaMailSender mailSender;

    public EmailService(JavaMailSender mailSender) {
        this.mailSender = mailSender;
    }

    public void sendEmail(String from, String subject, String message, String name, String phone) {
        SimpleMailMessage mailMessage = new SimpleMailMessage();
        mailMessage.setTo("sauravkumar87894@gmail.com"); // Your email to receive notifications
        mailMessage.setReplyTo(from); // User's email for replying
        mailMessage.setSubject(subject);
        mailMessage.setText(
            "From: " + from + "\n" + // User's email in the body
            "Name: " + name + "\n" +
            "Phone: " + phone + "\n" +
            "Message: " + message
        );

        mailSender.send(mailMessage);
    }
}