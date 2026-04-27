package co.sena.adso.util;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.security.SecureRandom;
import java.util.Base64;

import javax.imageio.ImageIO;

public class CaptchaGenerator {

    public static String generarTextoCaptcha() {
        String chars = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789"; // Sin I, O, 1, 0 para evitar confusiones
        StringBuilder sb = new StringBuilder();
        SecureRandom rnd = new SecureRandom();
        for (int i = 0; i < 5; i++) {
            sb.append(chars.charAt(rnd.nextInt(chars.length())));
        }
        return sb.toString();
    }

    public static String generarImagenBase64(String textoCaptcha) {
        int width = 150;
        int height = 50;
        BufferedImage bufferedImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        Graphics2D g2d = bufferedImage.createGraphics();

        // Fondo
        g2d.setColor(new Color(240, 244, 248));
        g2d.fillRect(0, 0, width, height);

        // Ruido (líneas)
        g2d.setColor(new Color(200, 200, 200));
        SecureRandom rnd = new SecureRandom();
        for (int i = 0; i < 15; i++) {
            g2d.drawLine(rnd.nextInt(width), rnd.nextInt(height), rnd.nextInt(width), rnd.nextInt(height));
        }

        // Texto
        g2d.setFont(new Font("Arial", Font.BOLD | Font.ITALIC, 30));
        g2d.setColor(new Color(26, 82, 118)); // Azul Institucional
        g2d.drawString(textoCaptcha, 25, 35);
        g2d.dispose();

        try {
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            ImageIO.write(bufferedImage, "png", baos);
            byte[] imageBytes = baos.toByteArray();
            return "data:image/png;base64," + Base64.getEncoder().encodeToString(imageBytes);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}