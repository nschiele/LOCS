function cite(paper){
    toReturn = ""
    toReturn += paper.author + ". "
    toReturn += "<b>" + paper.title + "</b>. "
if (paper.hasOwnProperty("journal")) {
    toReturn += "<i>" + paper.journal + "</i>"
    if (paper.hasOwnProperty("publisher")) {
        toReturn += ", " + paper.publisher + ", "
    } else {
        toReturn += ", "
    }
}
toReturn += paper.year + ". "
return toReturn
}