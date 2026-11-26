# -*- coding: utf-8 -*-
"""
HOMELY AI: Capstone Project Report Generator
Course: AI for Managers (PMC30022) | MBA Program | IILM University, Greater Noida
Strictly adheres to all 5 Rubric Criteria (CO1 to CO5) - 50 Marks Total
Generates a comprehensive 10-15 page professional academic report in DOCX format.
"""

import os
import sys
import docx
from docx import Document
from docx.shared import Inches, Pt, RGBColor
from docx.enum.text import WD_ALIGN_PARAGRAPH
from docx.enum.table import WD_TABLE_ALIGNMENT, WD_ALIGN_VERTICAL
from docx.oxml import OxmlElement, parse_xml
from docx.oxml.ns import nsdecls, qn

# --- Color Palette Constants ---
NAVY_PRIMARY = RGBColor(26, 54, 93)       # #1A365D - Deep Academic Navy
SLATE_SECONDARY = RGBColor(43, 108, 176)  # #2B6CB0 - Section Blue
CHARCOAL_BODY = RGBColor(45, 55, 72)      # #2D3748 - High-contrast readable body text
MUTED_TEAL = RGBColor(44, 122, 123)       # #2C7A7B - Accent & KPI highlights
COOL_GRAY = RGBColor(113, 128, 150)       # #718096 - Metadata & secondary captions
BG_LIGHT_GRAY = "F7FAFC"
BG_HEADER_NAVY = "1A365D"
BORDER_GRAY = "CBD5E0"

def set_cell_background(cell, hex_color):
    """Set background color of a table cell."""
    tcPr = cell._tc.get_or_add_tcPr()
    shd = parse_xml(f'<w:shd {nsdecls("w")} w:fill="{hex_color}"/>')
    tcPr.append(shd)

def set_cell_margins(cell, top=120, bottom=120, left=180, right=180):
    """Set padding in dxa (1 pt = 20 dxa)."""
    tcPr = cell._tc.get_or_add_tcPr()
    tcMar = OxmlElement('w:tcMar')
    for m, val in [('w:top', top), ('w:bottom', bottom), ('w:left', left), ('w:right', right)]:
        node = OxmlElement(m)
        node.set(qn('w:w'), str(val))
        node.set(qn('w:type'), 'dxa')
        tcMar.append(node)
    tcPr.append(tcMar)

def set_table_borders(table, color="CBD5E0", sz="4", val="single"):
    """Apply clean borders across table cells."""
    tblPr = table._tbl.tblPr
    borders = parse_xml(
        f'<w:tblBorders {nsdecls("w")}>'
        f'  <w:top w:val="{val}" w:sz="{sz}" w:space="0" w:color="{color}"/>'
        f'  <w:bottom w:val="{val}" w:sz="{sz}" w:space="0" w:color="{color}"/>'
        f'  <w:left w:val="none"/>'
        f'  <w:right w:val="none"/>'
        f'  <w:insideH w:val="{val}" w:sz="{sz}" w:space="0" w:color="{color}"/>'
        f'  <w:insideV w:val="none"/>'
        f'</w:tblBorders>'
    )
    tblPr.append(borders)

def add_callout_box(doc, title, text_content, border_color="1A365D", fill_color="F8FAFC"):
    """Create a high-impact managerial callout box with a colored left accent border."""
    tbl = doc.add_table(rows=1, cols=1)
    tbl.alignment = WD_TABLE_ALIGNMENT.CENTER
    tbl.autofit = False
    cell = tbl.cell(0, 0)
    cell.width = Inches(6.5)
    set_cell_background(cell, fill_color)
    set_cell_margins(cell, top=140, bottom=140, left=220, right=180)
    
    tcPr = cell._tc.get_or_add_tcPr()
    borders = parse_xml(
        f'<w:tcBorders {nsdecls("w")}>'
        f'  <w:left w:val="single" w:sz="36" w:space="0" w:color="{border_color}"/>'
        f'  <w:top w:val="none"/>'
        f'  <w:right w:val="none"/>'
        f'  <w:bottom w:val="none"/>'
        f'</w:tcBorders>'
    )
    tcPr.append(borders)
    
    p = cell.paragraphs[0]
    p.paragraph_format.space_before = Pt(2)
    p.paragraph_format.space_after = Pt(4)
    run_t = p.add_run(f"■ {title}\n")
    run_t.font.name = "Calibri"
    run_t.font.size = Pt(10.5)
    run_t.font.bold = True
    run_t.font.color.rgb = NAVY_PRIMARY
    
    run_c = p.add_run(text_content)
    run_c.font.name = "Calibri"
    run_c.font.size = Pt(9.5)
    run_c.font.color.rgb = CHARCOAL_BODY
    
    # Empty space after callout
    p_spacer = doc.add_paragraph()
    p_spacer.paragraph_format.space_before = Pt(0)
    p_spacer.paragraph_format.space_after = Pt(4)

def format_paragraph(p, space_before=0, space_after=6, line_spacing=1.15):
    """Set standard body paragraph metrics."""
    p.paragraph_format.space_before = Pt(space_before)
    p.paragraph_format.space_after = Pt(space_after)
    p.paragraph_format.line_spacing = line_spacing

def add_body_p(doc, text, bold_prefix="", space_after=6):
    """Add a professional body paragraph with consistent typography."""
    p = doc.add_paragraph()
    format_paragraph(p, space_after=space_after)
    if bold_prefix:
        r_pre = p.add_run(bold_prefix)
        r_pre.font.name = "Calibri"
        r_pre.font.size = Pt(10.5)
        r_pre.font.bold = True
        r_pre.font.color.rgb = NAVY_PRIMARY
    r = p.add_run(text)
    r.font.name = "Calibri"
    r.font.size = Pt(10.5)
    r.font.color.rgb = CHARCOAL_BODY
    return p

def add_h1(doc, text):
    """Heading 1 with executive navy styling and proper page spacing."""
    p = doc.add_paragraph()
    p.paragraph_format.space_before = Pt(16)
    p.paragraph_format.space_after = Pt(6)
    p.paragraph_format.keep_with_next = True
    r = p.add_run(text)
    r.font.name = "Georgia"
    r.font.size = Pt(16)
    r.font.bold = True
    r.font.color.rgb = NAVY_PRIMARY
    return p

def add_h2(doc, text):
    """Heading 2 with clean slate styling."""
    p = doc.add_paragraph()
    p.paragraph_format.space_before = Pt(12)
    p.paragraph_format.space_after = Pt(4)
    p.paragraph_format.keep_with_next = True
    r = p.add_run(text)
    r.font.name = "Georgia"
    r.font.size = Pt(13)
    r.font.bold = True
    r.font.color.rgb = SLATE_SECONDARY
    return p

def add_h3(doc, text):
    """Heading 3 with dark accent styling."""
    p = doc.add_paragraph()
    p.paragraph_format.space_before = Pt(8)
    p.paragraph_format.space_after = Pt(2)
    p.paragraph_format.keep_with_next = True
    r = p.add_run(text)
    r.font.name = "Calibri"
    r.font.size = Pt(11)
    r.font.bold = True
    r.font.color.rgb = MUTED_TEAL
    return p

print("Loaded generator core utilities.")
