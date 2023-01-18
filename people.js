function formatName(person, title=true){
    var toReturn = "";
    if(person.hasOwnProperty("title")&&title){
        toReturn += person.title + " "
    }
    toReturn += person.firstname + " "
    if(person.hasOwnProperty("tussenvoegsel")){
        toReturn += person.tussenvoegsel + " "
    }
    toReturn += person.lastname
    return toReturn
}

function setIDs(data){
    for(i in data){
        data[i].id = i
    }
    return data
}

//Takes dataset of people and the code, and returns the person with that code
function findPeople(data, code){
    for(i in data){
        if(data.init == code){
            return i
        }
    }
    return -1
}