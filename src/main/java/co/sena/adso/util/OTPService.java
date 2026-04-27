package co.sena.adso.util;

import java.security.SecureRandom;
import java.util.Properties;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class OTPService {
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final int SMTP_PORT = 587;
    private static final String EMAIL_REMIT = "tu_correo@gmail.com";
    private static final String EMAIL_PASS = System.getenv("EMAIL_PASS");

    public static String generarOTP() {
        SecureRandom rnd = new SecureRandom();
        StringBuilder sb = new StringBuilder(6);
        for (int i = 0; i < 6; i++) {
            sb.append(rnd.nextInt(10));
        }
        return sb.toString();
    }

    public static void enviarOTP(String destinatario, String codigoOTP, String asunto, String cuerpo) throws MessagingException, java.io.UnsupportedEncodingException {
        Properties props = new Properties();
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session mailSession = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(EMAIL_REMIT, EMAIL_PASS);
            }
        });

        Message mensaje = new MimeMessage(mailSession);
        mensaje.setFrom(new InternetAddress(EMAIL_REMIT, "Centro Médico"));
        mensaje.setRecipient(Message.RecipientType.TO, new InternetAddress(destinatario));
        mensaje.setSubject(asunto);
        mensaje.setText(cuerpo);
        Transport.send(mensaje);
    }
}