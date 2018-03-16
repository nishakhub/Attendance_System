package org.vpmpt.attendancemanage.business;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.DataFormat;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.PrintSetup;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.vpmpt.attendancemanage.beans.ReportDTO;

public class ExcelGenerator {
	private static final String[] titles = {
        "User ID", "Student Name", "Total Days", "Present Days", "Percentage"};
	public String getExcelSheet(List<ReportDTO> reportList) throws FileNotFoundException, IOException{

			XSSFWorkbook wb = new XSSFWorkbook();

	        Map<String, CellStyle> styles = createStyles(wb);

	        XSSFSheet sheet = wb.createSheet();

	        //turn off gridlines
//	        sheet.setDisplayGridlines(false);
	        sheet.setPrintGridlines(false);
	        sheet.setFitToPage(true);
	        sheet.setHorizontallyCenter(true);
	        PrintSetup printSetup = sheet.getPrintSetup();
	        printSetup.setLandscape(true);

	        //the following three statements are required only for HSSF
	        sheet.setAutobreaks(true);
	        printSetup.setFitHeight((short)1);
	        printSetup.setFitWidth((short)1);

	        //the header row: centered text in 48pt font
	        Row headerRow = sheet.createRow(0);
	        headerRow.setHeightInPoints(12.75f);
	        for (int i = 0; i < titles.length; i++) {
	            Cell cell = headerRow.createCell(i);
	            cell.setCellValue(titles[i]);
	            cell.setCellStyle(styles.get("header"));
	        }
	        
	        for (int i = 1; i < reportList.size()+1; i++) {
	        	Row row = sheet.createRow(i);
	        	ReportDTO reportDTO = reportList.get(i-1);
	        	
	        	Cell cell1 = row.createCell(0);
	            cell1.setCellValue(reportDTO.getUserId());
	            cell1.setCellStyle(styles.get("cell_normal"));
	            
	        	Cell cell2 = row.createCell(1);
	            cell2.setCellValue(reportDTO.getStudentName());
	            cell2.setCellStyle(styles.get("cell_normal"));
	            
	            
	        	Cell cell3 = row.createCell(2);
	            cell3.setCellValue(reportDTO.getTotalDays());
	            cell3.setCellStyle(styles.get("cell_normal"));
	            
	        	Cell cell4 = row.createCell(3);
	            cell4.setCellValue(reportDTO.getPresentDays());
	            cell4.setCellStyle(styles.get("cell_normal"));
	            
	        	Cell cell5 = row.createCell(4);
	            cell5.setCellValue(reportDTO.getPercentage());
	            cell5.setCellStyle(styles.get("cell_normal"));
	        	
			}
	        
	        // Write the output to a file
	        String fileName = "attendance"+System.currentTimeMillis()+".xlsx";
	        File file = new File("D:/"+fileName);
	        FileOutputStream out = new FileOutputStream(file);
	        wb.write(out);
	        out.close();
	        return fileName;
	    }

	    /**
	     * create a library of cell styles
	     */
	    private static Map<String, CellStyle> createStyles(XSSFWorkbook wb){
	        Map<String, CellStyle> styles = new HashMap<String, CellStyle>();
	        DataFormat df = wb.createDataFormat();

	        CellStyle style;
	        Font headerFont = wb.createFont();
	        headerFont.setBoldweight(Font.BOLDWEIGHT_BOLD);
	        style = createBorderedStyle(wb);
	        style.setAlignment(CellStyle.ALIGN_CENTER);
	        style.setFillForegroundColor(IndexedColors.LIGHT_CORNFLOWER_BLUE.getIndex());
	        style.setFillPattern(CellStyle.SOLID_FOREGROUND);
	        style.setFont(headerFont);
	        styles.put("header", style);

	        style = createBorderedStyle(wb);
	        style.setAlignment(CellStyle.ALIGN_CENTER);
	        style.setFillForegroundColor(IndexedColors.LIGHT_CORNFLOWER_BLUE.getIndex());
	        style.setFillPattern(CellStyle.SOLID_FOREGROUND);
	        style.setFont(headerFont);
	        style.setDataFormat(df.getFormat("d-mmm"));
	        styles.put("header_date", style);

	        Font font1 = wb.createFont();
	        font1.setBoldweight(Font.BOLDWEIGHT_BOLD);
	        style = createBorderedStyle(wb);
	        style.setAlignment(CellStyle.ALIGN_LEFT);
	        style.setFont(font1);
	        styles.put("cell_b", style);

	        style = createBorderedStyle(wb);
	        style.setAlignment(CellStyle.ALIGN_CENTER);
	        style.setFont(font1);
	        styles.put("cell_b_centered", style);

	        style = createBorderedStyle(wb);
	        style.setAlignment(CellStyle.ALIGN_RIGHT);
	        style.setFont(font1);
	        style.setDataFormat(df.getFormat("d-mmm"));
	        styles.put("cell_b_date", style);

	        style = createBorderedStyle(wb);
	        style.setAlignment(CellStyle.ALIGN_RIGHT);
	        style.setFont(font1);
	        style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
	        style.setFillPattern(CellStyle.SOLID_FOREGROUND);
	        style.setDataFormat(df.getFormat("d-mmm"));
	        styles.put("cell_g", style);
	        
	        style = createBorderedStyle(wb);
	        style.setAlignment(CellStyle.ALIGN_CENTER);
	        style.setFillForegroundColor(IndexedColors.RED.getIndex());
	        style.setFillPattern(CellStyle.SOLID_FOREGROUND);
	        style.setFont(headerFont);
	        styles.put("cell_bg_red", style);

	        Font font2 = wb.createFont();
	        font2.setColor(IndexedColors.BLUE.getIndex());
	        font2.setBoldweight(Font.BOLDWEIGHT_BOLD);
	        style = createBorderedStyle(wb);
	        style.setAlignment(CellStyle.ALIGN_LEFT);
	        style.setFont(font2);
	        styles.put("cell_bb", style);

	        style = createBorderedStyle(wb);
	        style.setAlignment(CellStyle.ALIGN_RIGHT);
	        style.setFont(font1);
	        style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
	        style.setFillPattern(CellStyle.SOLID_FOREGROUND);
	        style.setDataFormat(df.getFormat("d-mmm"));
	        styles.put("cell_bg", style);

	        Font font3 = wb.createFont();
	        font3.setFontHeightInPoints((short)14);
	        font3.setColor(IndexedColors.DARK_BLUE.getIndex());
	        font3.setBoldweight(Font.BOLDWEIGHT_BOLD);
	        style = createBorderedStyle(wb);
	        style.setAlignment(CellStyle.ALIGN_LEFT);
	        style.setFont(font3);
	        style.setWrapText(true);
	        styles.put("cell_h", style);

	        style = createBorderedStyle(wb);
	        style.setAlignment(CellStyle.ALIGN_LEFT);
	        style.setWrapText(true);
	        styles.put("cell_normal", style);

	        style = createBorderedStyle(wb);
	        style.setAlignment(CellStyle.ALIGN_CENTER);
	        style.setWrapText(true);
	        styles.put("cell_normal_centered", style);

	        style = createBorderedStyle(wb);
	        style.setAlignment(CellStyle.ALIGN_RIGHT);
	        style.setWrapText(true);
	        style.setDataFormat(df.getFormat("d-mmm"));
	        styles.put("cell_normal_date", style);

	        style = createBorderedStyle(wb);
	        style.setAlignment(CellStyle.ALIGN_LEFT);
	        style.setIndention((short)1);
	        style.setWrapText(true);
	        styles.put("cell_indented", style);

	        style = createBorderedStyle(wb);
	        style.setFillForegroundColor(IndexedColors.BLUE.getIndex());
	        style.setFillPattern(CellStyle.SOLID_FOREGROUND);
	        styles.put("cell_blue", style);

	        return styles;
	    }

	    private static CellStyle createBorderedStyle(XSSFWorkbook wb){
	        CellStyle style = wb.createCellStyle();
	        style.setBorderRight(CellStyle.BORDER_THIN);
	        style.setRightBorderColor(IndexedColors.BLACK.getIndex());
	        style.setBorderBottom(CellStyle.BORDER_THIN);
	        style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
	        style.setBorderLeft(CellStyle.BORDER_THIN);
	        style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
	        style.setBorderTop(CellStyle.BORDER_THIN);
	        style.setTopBorderColor(IndexedColors.BLACK.getIndex());
	        return style;
	    }
}
