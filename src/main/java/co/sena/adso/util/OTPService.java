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
    private static final String EMAIL_REMIT = "angeldanicp@gmail.com";
    private static final String EMAIL_PASS = "mavz gvqr zaqh ipmo";

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

        // Diseño Premium SaludBoyacá - "Apple Style" con cositas
        String cuerpoHTML = "<html>" +
            "<body style='background-color: #EAF0F7; font-family: -apple-system, BlinkMacSystemFont, \"Segoe UI\", Roboto, Helvetica, Arial, sans-serif; padding: 40px; margin: 0;'>" +
                "<div style='max-width: 550px; margin: auto; background: #FFFFFF; border-radius: 24px; overflow: hidden; box-shadow: 0 20px 40px rgba(0,0,0,0.08); border: 1px solid rgba(0,0,0,0.05);'>" +
                    
                    // HEADER INSTITUCIONAL (MORADO SEGURIDAD)
                    "<div style='background-color: #6C3483; padding: 40px 20px; text-align: center;'>" +
                        "<div style='background: rgba(255,255,255,0.2); display: inline-block; padding: 10px; border-radius: 12px; margin-bottom: 15px;'>" +
                            "<span style='font-size: 30px;'>🔐</span>" +
                        "</div>" +
                        "<h1 style='color: #FFFFFF; margin: 0; font-size: 26px; font-weight: 800; letter-spacing: -0.5px;'>SaludBoyacá</h1>" +
                        "<p style='color: rgba(255,255,255,0.7); margin: 5px 0 0 0; font-size: 14px; text-transform: uppercase; letter-spacing: 1px;'>Verificación de Identidad</p>" +
                    "</div>" +

                    // CUERPO DEL MENSAJE
                    "<div style='padding: 40px; text-align: center;'>" +
                        "<h2 style='color: #154360; font-size: 22px; margin-bottom: 10px;'>Confirmación de Acceso</h2>" +
                        "<p style='color: #2C3E50; font-size: 16px; line-height: 1.5;'>Para garantizar la seguridad de tus datos médicos, ingresa el siguiente código de un solo uso (OTP) en el portal:</p>" +
                        
                        // CAJA DEL CÓDIGO (AZUL CLARO INSTITUCIONAL)
                        "<div style='background-color: #D6EAF8; border-radius: 16px; padding: 30px; margin: 30px 0; border: 1px solid rgba(26, 82, 118, 0.1);'>" +
                            "<span style='font-size: 48px; font-weight: 800; color: #1A5276; letter-spacing: 12px; display: block;'>" + codigoOTP + "</span>" +
                            "<p style='color: #1A5276; font-size: 12px; margin-top: 10px; font-weight: 600;'>ESTE CÓDIGO EXPIRA EN 5 MINUTOS</p>" +
                        "</div>" +

                        // BLOQUE DE RECOMENDACIONES (VERDE SENA)
                        "<div style='text-align: left; background: #F4F9F1; padding: 20px; border-radius: 12px; border-left: 4px solid #39A900; margin-bottom: 25px;'>" +
                            "<h4 style='color: #39A900; margin: 0 0 10px 0; font-size: 14px;'><span style='margin-right: 8px;'>🛡️</span> Tips de Seguridad:</h4>" +
                            "<ul style='color: #2C3E50; font-size: 13px; margin: 0; padding-left: 20px; line-height: 1.6;'>" +
                                "<li>No compartas este código con nadie.</li>" +
                                "<li>Ningún funcionario te pedirá este código por teléfono.</li>" +
                                "<li>Si no solicitaste este acceso, cambia tu contraseña de inmediato.</li>" +
                            "</ul>" +
                        "</div>" +

                        "<p style='color: #7F8C8D; font-size: 13px;'>Si tienes problemas, contacta a soporte técnico de <b>SaludBoyacá</b>.</p>" +
                    "</div>" +

                    // FOOTER
                    "<div style='background-color: #F8F9FA; padding: 25px; text-align: center; border-top: 1px solid #EEEEEE;'>" +
                        "<p style='color: #7F8C8D; font-size: 11px; margin: 0; line-height: 1.5;'>" +
                            "&copy; 2026 <b>SaludBoyacá - Centro de Especialistas</b><br>" +
                            "ADSO CIMM SENA - Regional Boyacá, Colombia.<br>" +
                            "Este es un mensaje automático, por favor no respondas." +
                        "</p>" +
                    "</div>" +
                "</div>" +
            "</body>" +
            "</html>";

        Message mensaje = new MimeMessage(mailSession);
        mensaje.setFrom(new InternetAddress(EMAIL_REMIT, "Seguridad SaludBoyacá"));
        mensaje.setRecipient(Message.RecipientType.TO, new InternetAddress(destinatario));
        mensaje.setSubject(asunto);
        
        // Enviamos la nueva plantilla HTML con todas las "cositas"
        mensaje.setContent(cuerpoHTML, "text/html; charset=utf-8");
        
        Transport.send(mensaje);
    }
}