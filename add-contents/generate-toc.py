HEADER = '''\\documentclass[
,numbers=noendperiod
,twoside=false
]
{scrbook}
\\usepackage{pdfpages}
\\usepackage{hyperref}
\\begin{document}

\\tableofcontents
'''

FOOTER = '''\\end{document}'''

# \addcontentsline{toc}{chapter}{\protect\numberline{2} The first chapter name}% or chapter
TOC_ELEMENT = '''\\clearpage\\phantomsection
\\addcontentsline{toc}{%s}{\\protect\\numberline{%s} %s}
'''

INCLUDE_PDF = '''\\includepdf[pages={%d-%d}]{ctm.pdf}
'''

# preload this in a very unelegant way. lazy me.
pages = []
with open('toc.csv') as csv:
    for line in csv:
        _, page, _ = line.split(';')
        pages.append(int(page))

pages.append(897)
page_offset = 43
pages = [p+page_offset for p in pages]

with open('toc.csv') as csv:
    with open('ctm-with-toc.tex', 'w') as tex:
        # tex.write(HEADER)
        for line_num, line in enumerate(csv):
            title, page, _ = line.split(';')
            toc_index, title = title.split(' ', 1)

            toc_types = [
                (lambda t: t in ['I', 'II', 'III', 'IV', 'V'], 'part'),
                (lambda t: t.count('.') == 0, 'chapter'),
                (lambda t: t.count('.') == 1, 'section'),
                (lambda t: t.count('.') == 2, 'subsection')
            ]
            for test, toc_type in toc_types:
                if test(toc_index):
                    toc_element = TOC_ELEMENT % (toc_type, toc_index, title)
                    tex.write(toc_element)
                    print(toc_element)
                    start, end = pages[line_num], pages[line_num+1]
                    if start != end:
                        pdf_element = INCLUDE_PDF % (start, end-1)
                        tex.write(pdf_element)
                        print(pdf_element)
                    break

        #tex.write(FOOTER)
