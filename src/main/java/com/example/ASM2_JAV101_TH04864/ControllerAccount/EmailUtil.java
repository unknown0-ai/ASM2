package com.example.ASM2_JAV101_TH04864.ControllerAccount;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;
import java.util.Random;

public class EmailUtil {
    private static final String FROM_EMAIL = "nguyenvandai3520@gmail.com";     // THAY BẰNG EMAIL CỦA BẠN
    private static final String APP_PASSWORD = "kzjt cudb fnsc xlvs";     // Dùng App Password, không dùng mật khẩu thường

    // Gửi OTP qua email
    public static boolean sendOTP(String toEmail, String otp) {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Mã OTP đặt lại mật khẩu - Product Management");
            message.setText("Mã OTP của bạn là: " + otp + "Mã có hiệu lực trong 3 phút.");

            Transport.send(message);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Tạo OTP 6 chữ số
    public static String generateOTP() {
        return String.format("%06d", new Random().nextInt(1000000));
    }
}
