function cite(paper){
    html = ""
    html += paper.author + ". "
    html += "<b>" + paper.title + "</b>. "
if (paper.hasOwnProperty("journal")) {
    html += "<i>" + paper.journal + "</i>"
    if (paper.hasOwnProperty("publisher")) {
        html += ", " + paper.publisher + ", "
    } else {
        html += ", "
    }
}
html += paper.year + ". "
return html
}