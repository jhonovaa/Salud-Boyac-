package co.sena.adso.util;

import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.text.pdf.draw.LineSeparator;

import co.sena.adso.dto.Cita;

public class PDFGenerator {

    // Colores institucionales según los requerimientos del proyecto
    private static final BaseColor AZUL_SALUD = new BaseColor(26, 82, 118); // #1A5276
    private static final BaseColor VERDE_SENA = new BaseColor(57, 169, 0);  // #39A900
    private static final BaseColor GRIS_FONDO = new BaseColor(234, 240, 247); // #EAF0F7

    // Fuentes
    private static final Font FONT_TITULO = new Font(Font.FontFamily.HELVETICA, 18, Font.BOLD, AZUL_SALUD);
    private static final Font FONT_SUBTITULO = new Font(Font.FontFamily.HELVETICA, 12, Font.NORMAL, BaseColor.DARK_GRAY);
    private static final Font FONT_HEADER_TABLA = new Font(Font.FontFamily.HELVETICA, 11, Font.BOLD, BaseColor.WHITE);
    private static final Font FONT_TEXTO = new Font(Font.FontFamily.HELVETICA, 11, Font.NORMAL, BaseColor.BLACK);
    private static final Font FONT_TEXTO_BOLD = new Font(Font.FontFamily.HELVETICA, 11, Font.BOLD, BaseColor.BLACK);

    public static void generarComprobanteCita(Cita cita, OutputStream out) throws Exception {
        // Inicializamos el documento con márgenes
        Document document = new Document();
        PdfWriter.getInstance(document, out);
        document.open();

        // 1. Encabezado del Comprobante
        Paragraph titulo = new Paragraph("SALUDBOYACÁ", FONT_TITULO);
        titulo.setAlignment(Element.ALIGN_CENTER);
        document.add(titulo);

        Paragraph subtitulo = new Paragraph("Centro de Salud Municipal de Paipa", FONT_SUBTITULO);
        subtitulo.setAlignment(Element.ALIGN_CENTER);
        document.add(subtitulo);

        Paragraph tituloComprobante = new Paragraph("COMPROBANTE DE CITA MÉDICA", new Font(Font.FontFamily.HELVETICA, 14, Font.BOLD, VERDE_SENA));
        tituloComprobante.setAlignment(Element.ALIGN_CENTER);
        tituloComprobante.setSpacingBefore(10);
        tituloComprobante.setSpacingAfter(15);
        document.add(tituloComprobante);

        // Línea separadora
        LineSeparator separator = new LineSeparator();
        separator.setLineColor(AZUL_SALUD);
        document.add(new Chunk(separator));
        document.add(new Paragraph(" ")); // Espacio en blanco

        // 2. Tabla con los datos de la cita
        PdfPTable table = new PdfPTable(2);
        table.setWidthPercentage(100);
        table.setSpacingBefore(10f);
        table.setSpacingAfter(10f);
        table.setWidths(new float[]{35f, 65f}); // Anchos de las columnas

        // Fila de encabezado de tabla
        PdfPCell cellHeader = new PdfPCell(new Phrase("DETALLES DE LA CITA", FONT_HEADER_TABLA));
        cellHeader.setColspan(2);
        cellHeader.setHorizontalAlignment(Element.ALIGN_CENTER);
        cellHeader.setBackgroundColor(AZUL_SALUD);
        cellHeader.setPadding(8f);
        table.addCell(cellHeader);

        // Agregando las filas de datos
        agregarFilaTabla(table, "Número de Cita (ID):", String.valueOf(cita.getId()), true);
        agregarFilaTabla(table, "Paciente:", cita.getPacienteNombre(), false);
        agregarFilaTabla(table, "Documento Paciente:", cita.getPacienteDocumento(), true);
        agregarFilaTabla(table, "Médico Asignado:", cita.getMedicoNombre(), false);
        agregarFilaTabla(table, "Especialidad:", cita.getEspecialidadNombre(), true);
        agregarFilaTabla(table, "Fecha de la Cita:", cita.getFechaCita().toString(), false);
        agregarFilaTabla(table, "Hora de la Cita:", cita.getHoraCita().toString(), true);
        
        // Fila especial para el estado
        PdfPCell cellLabelEstado = new PdfPCell(new Phrase("Estado Actual:", FONT_TEXTO_BOLD));
        cellLabelEstado.setPadding(8f);
        cellLabelEstado.setBorderColor(BaseColor.LIGHT_GRAY);
        table.addCell(cellLabelEstado);
        
        Font fontEstado = new Font(Font.FontFamily.HELVETICA, 11, Font.BOLD, VERDE_SENA);
        if(cita.getEstado().equals("CANCELADA")) {
            fontEstado.setColor(BaseColor.RED);
        } else if (cita.getEstado().equals("PROGRAMADA")) {
            fontEstado.setColor(new BaseColor(243, 156, 18)); // Ámbar
        }
        
        PdfPCell cellValorEstado = new PdfPCell(new Phrase(cita.getEstado(), fontEstado));
        cellValorEstado.setPadding(8f);
        cellValorEstado.setBorderColor(BaseColor.LIGHT_GRAY);
        table.addCell(cellValorEstado);

        document.add(table);

        // 3. Pie de página
        document.add(new Paragraph(" "));
        document.add(new Chunk(separator));
        
        String fechaImpresion = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(new Date());
        Paragraph footer = new Paragraph("Documento generado el: " + fechaImpresion + "\nSENA · CIMM · Regional Boyacá · ADSO 2026", new Font(Font.FontFamily.HELVETICA, 9, Font.ITALIC, BaseColor.GRAY));
        footer.setAlignment(Element.ALIGN_CENTER);
        footer.setSpacingBefore(10);
        document.add(footer);

        document.close();
    }

    // Método auxiliar para no repetir código creando celdas
    private static void agregarFilaTabla(PdfPTable table, String etiqueta, String valor, boolean fondoGris) {
        PdfPCell cellEtiqueta = new PdfPCell(new Phrase(etiqueta, FONT_TEXTO_BOLD));
        PdfPCell cellValor = new PdfPCell(new Phrase(valor != null ? valor : "N/A", FONT_TEXTO));

        cellEtiqueta.setPadding(8f);
        cellValor.setPadding(8f);
        cellEtiqueta.setBorderColor(BaseColor.LIGHT_GRAY);
        cellValor.setBorderColor(BaseColor.LIGHT_GRAY);

        if (fondoGris) {
            cellEtiqueta.setBackgroundColor(GRIS_FONDO);
            cellValor.setBackgroundColor(GRIS_FONDO);
        }

        table.addCell(cellEtiqueta);
        table.addCell(cellValor);
    }
}