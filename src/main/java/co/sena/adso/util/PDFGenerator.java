package co.sena.adso.util;

import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;

import co.sena.adso.dto.Cita;

public class PDFGenerator {

    public static void generarComprobanteCita(Cita cita, OutputStream out) {
        Document document = new Document();
        try {
            PdfWriter.getInstance(document, out);
            document.open();

            // Fuentes personalizadas
            Font fontTitulo = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18, BaseColor.DARK_GRAY);
            Font fontSubtitulo = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12, new BaseColor(26, 82, 118)); // Azul Salud
            Font fontNormal = FontFactory.getFont(FontFactory.HELVETICA, 11, BaseColor.BLACK);

            // Título
            Paragraph titulo = new Paragraph("Comprobante de Cita Médica", fontTitulo);
            titulo.setAlignment(Element.ALIGN_CENTER);
            titulo.setSpacingAfter(20);
            document.add(titulo);

            // Datos de la Entidad
            document.add(new Paragraph("Centro de Salud Municipal de Paipa", fontSubtitulo));
            document.add(new Paragraph("Fecha de generación: " + new SimpleDateFormat("dd/MM/yyyy HH:mm").format(new Date()), fontNormal));
            document.add(Chunk.NEWLINE);

            // Datos del Paciente (usando el enfoque de cédula/documento)
            document.add(new Paragraph("DATOS DEL PACIENTE", fontSubtitulo));
            document.add(new Paragraph("Nombre: " + cita.getPacienteNombre(), fontNormal));
            document.add(new Paragraph("Cédula/Documento: " + cita.getPacienteDocumento(), fontNormal));
            document.add(Chunk.NEWLINE);

            // Detalles de la Cita
            document.add(new Paragraph("DETALLES DE LA ATENCIÓN", fontSubtitulo));
            document.add(new Paragraph("Fecha programada: " + cita.getFechaCita().toString(), fontNormal));
            document.add(new Paragraph("Hora: " + cita.getHoraCita().toString(), fontNormal));
            document.add(new Paragraph("Especialidad: " + cita.getEspecialidadNombre(), fontNormal));
            document.add(new Paragraph("Médico Asignado: " + cita.getMedicoNombre(), fontNormal));
            document.add(new Paragraph("Estado actual: " + cita.getEstado(), fontNormal));

            document.close();
        } catch (Exception e) {
            System.err.println("Error generando PDF: " + e.getMessage());
        }
    }
}