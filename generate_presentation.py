"""Generate the 6-slide HOMELY presentation using python-pptx.

Usage:
    pip install python-pptx
    python generate_presentation.py
"""

from pptx import Presentation
from pptx.dml.color import RGBColor
from pptx.enum.shapes import MSO_SHAPE
from pptx.enum.text import PP_ALIGN, MSO_ANCHOR
from pptx.util import Inches, Pt

# Serene Domesticity Palette
DARK_BG = RGBColor(0x15, 0x17, 0x14)
DARK_CARD = RGBColor(0x22, 0x27, 0x20)
DARK_BORDER = RGBColor(0x34, 0x3A, 0x33)
LIGHT_BG = RGBColor(0xF7, 0xF7, 0xF2)
LIGHT_SURFACE = RGBColor(0xEF, 0xEF, 0xE8)
WHITE = RGBColor(0xFF, 0xFF, 0xFF)
BORDER_LIGHT = RGBColor(0xE7, 0xE8, 0xE1)
TEXT_PRIMARY = RGBColor(0x20, 0x23, 0x1F)
TEXT_MUTED = RGBColor(0x77, 0x7B, 0x73)
SAGE_ACCENT = RGBColor(0x8B, 0xAF, 0x91)
SAGE_LUMINOUS = RGBColor(0x9B, 0xBD, 0xA0)
SAGE_DEEP = RGBColor(0x4E, 0x6E, 0x54)
TERRACOTTA = RGBColor(0xD9, 0x77, 0x57)
TERRACOTTA_BG = RGBColor(0xF9, 0xE7, 0xE2)
DARK_MUTED = RGBColor(0xA1, 0xA7, 0x9E)


def set_slide_bg(slide, color: RGBColor) -> None:
    fill = slide.background.fill
    fill.solid()
    fill.fore_color.rgb = color


def add_rounded_card(slide, x, y, w, h, fill_color, border_color=None):
    shape = slide.shapes.add_shape(
        MSO_SHAPE.ROUNDED_RECTANGLE, Inches(x), Inches(y), Inches(w), Inches(h)
    )
    shape.adjustments[0] = 0.08
    shape.fill.solid()
    shape.fill.fore_color.rgb = fill_color
    if border_color:
        shape.line.color.rgb = border_color
        shape.line.width = Pt(1)
    else:
        shape.line.fill.background()
    return shape


def add_header(slide, kicker: str, title: str, slide_num: int) -> None:
    set_slide_bg(slide, LIGHT_BG)
    # Top accent bar
    bar = slide.shapes.add_shape(
        MSO_SHAPE.RECTANGLE, Inches(0), Inches(0), Inches(10), Inches(0.08)
    )
    bar.fill.solid()
    bar.fill.fore_color.rgb = SAGE_ACCENT
    bar.line.fill.background()

    # Kicker
    tb_k = slide.shapes.add_textbox(Inches(0.6), Inches(0.25), Inches(8.8), Inches(0.25))
    tf_k = tb_k.text_frame
    tf_k.margin_left = tf_k.margin_top = tf_k.margin_right = tf_k.margin_bottom = 0
    p_k = tf_k.paragraphs[0]
    r_k = p_k.add_run()
    r_k.text = kicker
    r_k.font.size = Pt(10)
    r_k.font.bold = True
    r_k.font.color.rgb = SAGE_DEEP

    # Title
    tb_t = slide.shapes.add_textbox(Inches(0.6), Inches(0.5), Inches(8.8), Inches(0.5))
    tf_t = tb_t.text_frame
    tf_t.margin_left = tf_t.margin_top = tf_t.margin_right = tf_t.margin_bottom = 0
    p_t = tf_t.paragraphs[0]
    r_t = p_t.add_run()
    r_t.text = title
    r_t.font.size = Pt(24)
    r_t.font.bold = True
    r_t.font.color.rgb = TEXT_PRIMARY

    # Footer
    tb_f = slide.shapes.add_textbox(Inches(0.6), Inches(5.25), Inches(6.5), Inches(0.25))
    p_f = tb_f.text_frame.paragraphs[0]
    r_f = p_f.add_run()
    r_f.text = "HOMELY  |  Your home. Your data. Your control."
    r_f.font.size = Pt(9)
    r_f.font.color.rgb = TEXT_MUTED

    tb_n = slide.shapes.add_textbox(Inches(9.0), Inches(5.25), Inches(0.5), Inches(0.25))
    p_n = tb_n.text_frame.paragraphs[0]
    p_n.alignment = PP_ALIGN.RIGHT
    r_n = p_n.add_run()
    r_n.text = str(slide_num)
    r_n.font.size = Pt(9)
    r_n.font.color.rgb = TEXT_MUTED


def build_presentation(output_path: str = "HOMELY_Presentation.pptx") -> None:
    prs = Presentation()
    prs.slide_width = Inches(10)
    prs.slide_height = Inches(5.625)
    blank_layout = prs.slide_layouts[6]

    # ==========================================
    # SLIDE 1: TITLE
    # ==========================================
    s1 = prs.slides.add_slide(blank_layout)
    set_slide_bg(s1, DARK_BG)

    stripe = s1.shapes.add_shape(
        MSO_SHAPE.RECTANGLE, Inches(0), Inches(0), Inches(0.18), Inches(5.625)
    )
    stripe.fill.solid()
    stripe.fill.fore_color.rgb = SAGE_ACCENT
    stripe.line.fill.background()

    tb = s1.shapes.add_textbox(Inches(0.8), Inches(1.4), Inches(8.4), Inches(2.5))
    tf = tb.text_frame
    tf.word_wrap = True

    p1 = tf.paragraphs[0]
    r1 = p1.add_run()
    r1.text = "HOMELY"
    r1.font.size = Pt(48)
    r1.font.bold = True
    r1.font.color.rgb = LIGHT_BG

    p2 = tf.add_paragraph()
    p2.space_before = Pt(8)
    r2 = p2.add_run()
    r2.text = "Your home. Your data. Your control."
    r2.font.size = Pt(22)
    r2.font.color.rgb = SAGE_LUMINOUS

    p3 = tf.add_paragraph()
    p3.space_before = Pt(16)
    r3 = p3.add_run()
    r3.text = (
        "100% Offline-First Android Household Operating System\n"
        "Built with Flutter, Riverpod, Drift (SQLite) & Material 3"
    )
    r3.font.size = Pt(13)
    r3.font.color.rgb = TEXT_MUTED

    pills = ["10 Core Modules", "14 SQLite Tables", "Zero Cloud / Zero Telemetry"]
    for idx, label in enumerate(pills):
        px = 0.8 + idx * 2.35
        pill = add_rounded_card(s1, px, 4.45, 2.2, 0.38, DARK_CARD, DARK_BORDER)
        pill.adjustments[0] = 0.5
        ptf = pill.text_frame
        ptf.vertical_anchor = MSO_ANCHOR.MIDDLE
        pp = ptf.paragraphs[0]
        pp.alignment = PP_ALIGN.CENTER
        pr = pp.add_run()
        pr.text = label
        pr.font.size = Pt(10.5)
        pr.font.bold = True
        pr.font.color.rgb = SAGE_LUMINOUS

    # ==========================================
    # SLIDE 2: SUMMARY
    # ==========================================
    s2 = prs.slides.add_slide(blank_layout)
    add_header(s2, "EXECUTIVE SUMMARY", "A Calm, Private Household Operating System", 2)

    stats = [
        ("10", "Core Functional Modules", "Inventory, Bills, Assets, Vehicles & more"),
        ("14", "Normalized SQLite Tables", "Powered by Drift with integer paise currency"),
        ("100%", "Offline-First Privacy", "No accounts, no cloud sync, no telemetry"),
    ]
    for i, (num, label, sub) in enumerate(stats):
        sy = 1.25 + i * 1.25
        add_rounded_card(s2, 0.6, sy, 3.4, 1.08, WHITE, BORDER_LIGHT)
        tb_num = s2.shapes.add_textbox(Inches(0.75), Inches(sy + 0.1), Inches(1.05), Inches(0.88))
        tf_num = tb_num.text_frame
        tf_num.vertical_anchor = MSO_ANCHOR.MIDDLE
        p_num = tf_num.paragraphs[0]
        p_num.alignment = PP_ALIGN.CENTER
        r_num = p_num.add_run()
        r_num.text = num
        r_num.font.size = Pt(28)
        r_num.font.bold = True
        r_num.font.color.rgb = SAGE_DEEP

        tb_txt = s2.shapes.add_textbox(Inches(1.85), Inches(sy + 0.12), Inches(2.0), Inches(0.84))
        tf_txt = tb_txt.text_frame
        tf_txt.word_wrap = True
        tf_txt.vertical_anchor = MSO_ANCHOR.MIDDLE
        p_lbl = tf_txt.paragraphs[0]
        r_lbl = p_lbl.add_run()
        r_lbl.text = label
        r_lbl.font.size = Pt(12)
        r_lbl.font.bold = True
        r_lbl.font.color.rgb = TEXT_PRIMARY
        p_sub = tf_txt.add_paragraph()
        r_sub = p_sub.add_run()
        r_sub.text = sub
        r_sub.font.size = Pt(9.5)
        r_sub.font.color.rgb = TEXT_MUTED

    add_rounded_card(s2, 4.3, 1.25, 5.1, 3.6, LIGHT_SURFACE, BORDER_LIGHT)
    tb_r = s2.shapes.add_textbox(Inches(4.55), Inches(1.45), Inches(4.6), Inches(3.2))
    tf_r = tb_r.text_frame
    tf_r.word_wrap = True
    p_rh = tf_r.paragraphs[0]
    r_rh = p_rh.add_run()
    r_rh.text = "What HOMELY Delivers"
    r_rh.font.size = Pt(15)
    r_rh.font.bold = True
    r_rh.font.color.rgb = TEXT_PRIMARY

    bullets_s2 = [
        ("Unified Daily Control: ", "Brings groceries, recurring bills, appliance warranties, vehicle logs, and documents into one cohesive app."),
        ("Financial Precision: ", "Strict integer paise architecture (100 paise = ₹1.00) eliminates floating-point rounding errors."),
        ("Reactive & Local: ", "Built with Flutter 3+, Riverpod, GoRouter, and local Android notifications for instant performance."),
        ("Full Data Ownership: ", "One-tap JSON/SQLite export and validated local restore keep users in complete control."),
    ]
    for lead, body in bullets_s2:
        p = tf_r.add_paragraph()
        p.space_before = Pt(10)
        r_l = p.add_run()
        r_l.text = f"• {lead}"
        r_l.font.size = Pt(11.5)
        r_l.font.bold = True
        r_l.font.color.rgb = TEXT_PRIMARY
        r_b = p.add_run()
        r_b.text = body
        r_b.font.size = Pt(11.5)
        r_b.font.color.rgb = TEXT_PRIMARY

    # ==========================================
    # SLIDE 3: HOW WE MADE IT WITH ANTIGRAVITY
    # ==========================================
    s3 = prs.slides.add_slide(blank_layout)
    add_header(s3, "ENGINEERING WORKFLOW", "How We Built HOMELY with Antigravity", 3)

    steps = [
        ("01", "Stitch Design System", "Translated Serene Domesticity Stitch tokens into Light (#F7F7F2) & Dark (#151714) Material 3 themes, Manrope/Inter typography, and reusable widgets."),
        ("02", "Feature-First Architecture", "Scaffolded clean lib/app/, lib/core/, and lib/features/ modules with GoRouter ShellRoute (5-tab navigation) and reactive Riverpod providers."),
        ("03", "Drift SQLite & Domain Logic", "Generated 14 normalized SQLite tables, integer paise currency formatting, end-of-month bill recurrence clamping, and Unified Calendar aggregation."),
        ("04", "Verification & Android Release", "Validated with dart-mcp-server, unit & widget test suites, and configured AndroidManifest.xml & Gradle for release builds."),
    ]
    for idx, (num, title, desc) in enumerate(steps):
        col, row = idx % 2, idx // 2
        cx, cy = 0.6 + col * 4.55, 1.25 + row * 1.85
        add_rounded_card(s3, cx, cy, 4.25, 1.65, WHITE, BORDER_LIGHT)

        badge = add_rounded_card(s3, cx + 0.2, cy + 0.2, 0.48, 0.34, SAGE_ACCENT)
        btf = badge.text_frame
        btf.vertical_anchor = MSO_ANCHOR.MIDDLE
        bp = btf.paragraphs[0]
        bp.alignment = PP_ALIGN.CENTER
        br = bp.add_run()
        br.text = num
        br.font.size = Pt(11)
        br.font.bold = True
        br.font.color.rgb = WHITE

        tb_st = s3.shapes.add_textbox(Inches(cx + 0.78), Inches(cy + 0.2), Inches(3.3), Inches(0.34))
        p_st = tb_st.text_frame.paragraphs[0]
        r_st = p_st.add_run()
        r_st.text = title
        r_st.font.size = Pt(13.5)
        r_st.font.bold = True
        r_st.font.color.rgb = TEXT_PRIMARY

        tb_sd = s3.shapes.add_textbox(Inches(cx + 0.2), Inches(cy + 0.64), Inches(3.85), Inches(0.88))
        tf_sd = tb_sd.text_frame
        tf_sd.word_wrap = True
        p_sd = tf_sd.paragraphs[0]
        r_sd = p_sd.add_run()
        r_sd.text = desc
        r_sd.font.size = Pt(10.5)
        r_sd.font.color.rgb = TEXT_MUTED

    # ==========================================
    # SLIDE 4: BUSINESS PROBLEM IT IS SOLVING
    # ==========================================
    s4 = prs.slides.add_slide(blank_layout)
    add_header(s4, "PROBLEM & SOLUTION", "Solving Household Fragmentation & Privacy Loss", 4)

    # Left: Problem
    add_rounded_card(s4, 0.6, 1.25, 4.25, 3.65, WHITE, BORDER_LIGHT)
    p_badge = add_rounded_card(s4, 0.8, 1.45, 1.5, 0.3, TERRACOTTA_BG)
    p_badge.adjustments[0] = 0.5
    pp = p_badge.text_frame.paragraphs[0]
    pp.alignment = PP_ALIGN.CENTER
    pr = pp.add_run()
    pr.text = "THE PROBLEM"
    pr.font.size = Pt(9.5)
    pr.font.bold = True
    pr.font.color.rgb = TERRACOTTA

    tb_p = s4.shapes.add_textbox(Inches(0.8), Inches(1.9), Inches(3.85), Inches(2.8))
    tf_p = tb_p.text_frame
    tf_p.word_wrap = True
    prob_items = [
        ("App & Tool Fragmentation: ", "Households juggle spreadsheets for bills, notes for groceries, folders for warranties, and separate vehicle logs."),
        ("Privacy & Subscription Fatigue: ", "Cloud apps monetize personal spending data or lock basic tracking behind recurring fees."),
        ("Missed Renewals & Waste: ", "Forgotten utility due dates, expired pantry items, and lost warranty slips cost families time and money."),
    ]
    for i, (lead, body) in enumerate(prob_items):
        p = tf_p.paragraphs[0] if i == 0 else tf_p.add_paragraph()
        if i > 0:
            p.space_before = Pt(12)
        r1 = p.add_run()
        r1.text = f"• {lead}"
        r1.font.size = Pt(11)
        r1.font.bold = True
        r1.font.color.rgb = TEXT_PRIMARY
        r2 = p.add_run()
        r2.text = body
        r2.font.size = Pt(11)
        r2.font.color.rgb = TEXT_MUTED

    # Right: Solution
    add_rounded_card(s4, 5.15, 1.25, 4.25, 3.65, DARK_BG)
    s_badge = add_rounded_card(s4, 5.35, 1.45, 1.75, 0.3, DARK_CARD, DARK_BORDER)
    s_badge.adjustments[0] = 0.5
    sp = s_badge.text_frame.paragraphs[0]
    sp.alignment = PP_ALIGN.CENTER
    sr = sp.add_run()
    sr.text = "HOMELY SOLUTION"
    sr.font.size = Pt(9.5)
    sr.font.bold = True
    sr.font.color.rgb = SAGE_LUMINOUS

    tb_s = s4.shapes.add_textbox(Inches(5.35), Inches(1.9), Inches(3.85), Inches(2.8))
    tf_s = tb_s.text_frame
    tf_s.word_wrap = True
    sol_items = [
        ("Single Unified OS: ", "10 interconnected modules share one local SQLite database and Unified Calendar."),
        ("100% On-Device Privacy: ", "Zero cloud servers, zero ads, and full JSON/SQLite backup portability."),
        ("Proactive Local Alerts: ", "Dedicated Android notification channels for bills, low stock, warranties, and vehicle renewals."),
    ]
    for i, (lead, body) in enumerate(sol_items):
        p = tf_s.paragraphs[0] if i == 0 else tf_s.add_paragraph()
        if i > 0:
            p.space_before = Pt(12)
        r1 = p.add_run()
        r1.text = f"• {lead}"
        r1.font.size = Pt(11)
        r1.font.bold = True
        r1.font.color.rgb = LIGHT_BG
        r2 = p.add_run()
        r2.text = body
        r2.font.size = Pt(11)
        r2.font.color.rgb = DARK_MUTED

    # ==========================================
    # SLIDE 5: FEATURES IN THIS APP
    # ==========================================
    s5 = prs.slides.add_slide(blank_layout)
    add_header(s5, "CORE CAPABILITIES", "10 Integrated Modules Built for Daily Life", 5)

    features = [
        ("Dashboard & Quick-Add", "Real-time monthly spend, pending bills, low-stock alerts, and 6-action speed-dial sheet."),
        ("Inventory & Shopping", "Pantry quantity steppers, expiry tracking, and wishlist buckets with 1-tap inventory conversion."),
        ("Bills & Subscriptions", "Utility & OTT manager with end-of-month recurrence clamping, Mark as Paid, and history."),
        ("Assets & Vehicles", "Appliance warranty countdowns, service timelines, odometer, fuel logs, and PUC/insurance alerts."),
        ("Calendar & Reminders", "Unified cross-module schedule + Overdue, Upcoming, and 1-day snooze task management."),
        ("Expenses, Vault & Backup", "fl_chart category analytics, local Document Vault for receipts/RC, and JSON/SQLite export."),
    ]
    for idx, (title, desc) in enumerate(features):
        col, row = idx % 3, idx // 3
        fx, fy = 0.6 + col * 3.0, 1.25 + row * 1.85
        add_rounded_card(s5, fx, fy, 2.8, 1.65, WHITE, BORDER_LIGHT)

        dot = s5.shapes.add_shape(
            MSO_SHAPE.OVAL, Inches(fx + 0.18), Inches(fy + 0.18), Inches(0.28), Inches(0.28)
        )
        dot.fill.solid()
        dot.fill.fore_color.rgb = SAGE_ACCENT
        dot.line.fill.background()

        tb_ft = s5.shapes.add_textbox(Inches(fx + 0.55), Inches(fy + 0.16), Inches(2.1), Inches(0.34))
        p_ft = tb_ft.text_frame.paragraphs[0]
        r_ft = p_ft.add_run()
        r_ft.text = title
        r_ft.font.size = Pt(12)
        r_ft.font.bold = True
        r_ft.font.color.rgb = TEXT_PRIMARY

        tb_fd = s5.shapes.add_textbox(Inches(fx + 0.18), Inches(fy + 0.6), Inches(2.44), Inches(0.9))
        tf_fd = tb_fd.text_frame
        tf_fd.word_wrap = True
        p_fd = tf_fd.paragraphs[0]
        r_fd = p_fd.add_run()
        r_fd.text = desc
        r_fd.font.size = Pt(10)
        r_fd.font.color.rgb = TEXT_MUTED

    # ==========================================
    # SLIDE 6: FUTURE PLANNED FEATURES
    # ==========================================
    s6 = prs.slides.add_slide(blank_layout)
    add_header(s6, "PRODUCT ROADMAP", "Future Planned Features Through Updates", 6)

    line = s6.shapes.add_shape(
        MSO_SHAPE.RECTANGLE, Inches(1.0), Inches(1.94), Inches(8.0), Inches(0.03)
    )
    line.fill.solid()
    line.fill.fore_color.rgb = SAGE_ACCENT
    line.line.fill.background()

    roadmap = [
        ("v1.1", "Smart Capture", ["On-device OCR receipt & warranty scanning", "Barcode scanning for instant pantry entry"]),
        ("v1.2", "Private Family Sync", ["Encrypted peer-to-peer local network sync", "Shared household lists without cloud servers"]),
        ("v1.3", "Widgets & Insights", ["Android home-screen quick-add & bill widgets", "On-device monthly spend forecasting"]),
        ("v2.0", "Cross-Platform", ["iOS & Desktop companion apps", "End-to-end encrypted backup sync"]),
    ]
    for idx, (ver, title, items) in enumerate(roadmap):
        rx = 0.6 + idx * 2.28
        vpill = add_rounded_card(s6, rx + 0.65, 1.77, 0.9, 0.36, DARK_BG)
        vpill.adjustments[0] = 0.5
        vp = vpill.text_frame.paragraphs[0]
        vp.alignment = PP_ALIGN.CENTER
        vr = vp.add_run()
        vr.text = ver
        vr.font.size = Pt(11)
        vr.font.bold = True
        vr.font.color.rgb = SAGE_LUMINOUS

        add_rounded_card(s6, rx, 2.35, 2.1, 2.5, WHITE, BORDER_LIGHT)
        tb_rt = s6.shapes.add_textbox(Inches(rx + 0.15), Inches(2.5), Inches(1.8), Inches(2.2))
        tf_rt = tb_rt.text_frame
        tf_rt.word_wrap = True
        p_rt = tf_rt.paragraphs[0]
        r_rt = p_rt.add_run()
        r_rt.text = title
        r_rt.font.size = Pt(12.5)
        r_rt.font.bold = True
        r_rt.font.color.rgb = TEXT_PRIMARY

        for item in items:
            p_ri = tf_rt.add_paragraph()
            p_ri.space_before = Pt(8)
            r_ri = p_ri.add_run()
            r_ri.text = f"• {item}"
            r_ri.font.size = Pt(10)
            r_ri.font.color.rgb = TEXT_MUTED

    prs.save(output_path)
    print(f"Saved {output_path}")


if __name__ == "__main__":
    build_presentation()
