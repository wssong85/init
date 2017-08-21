package pantheon.com.util;

import com.itextpdf.text.Document;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfPageEventHelper;
import com.itextpdf.text.pdf.PdfWriter;

public class FooterTable extends PdfPageEventHelper {
	
    protected PdfPTable footer;
    
    public FooterTable(PdfPTable footer) {
        this.footer = footer;
    }
    
    public void onEndPage(PdfWriter writer, Document document) {
        footer.writeSelectedRows(0, -1, document.left(), 64, writer.getDirectContent());
    }
}
