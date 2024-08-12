package utils;

import java.util.Date;
import java.util.Iterator;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.activation.DataHandler;

public class Email {

    //Email: de170703phamthanhtung@gmail.com
    //Password: ughkzrwlsowbpxvl

public void sendEmail(String toEmail, String msg){
        final String from = "de170703phamthanhtung@gmail.com";
        final String password = "ughkzrwlsowbpxvl";
    //Properties : Khai báo các thuộc tính
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");//SMTP HOST
        props.put("mail.smtp.port", "587");//TLS 587 SSL 465
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        //Create Authenticator
        Authenticator auth = new Authenticator() {
            @Override
protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        };

        //Phiên làm việc
        Session session = Session.getInstance(props, auth);


        //Tạo một tin nhắn
        MimeMessage mess = new MimeMessage(session);

        try {
            mess.addHeader("Content-type", "text/html; charset=UTF-8");
            //Người gửi
            mess.setFrom(from);
            //Người nhận
            mess.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail, false));
            //Tiêu đề email
            mess.setSubject("Xác Nhận Email");
            //Quy định ngày gửi email
            mess.setSentDate(new Date());
            //Quy đinh email nhận phản hồi
            //mess.setReplyTo(InternetAddress.parse(from, false));
            //Nội dung
            mess.setText(msg);
            Transport.send(mess);
            System.out.println("Gửi email thành công");
        } catch (Exception e) {
            System.out.println("Lỗi gửi email");
        }
    }
    

}
