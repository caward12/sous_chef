$(document).ready(function(){
  bindRecipewithGroceryList()
})

function bindRecipewithGroceryList(){
  $("#new-grocery").on("click", function(event){
    event.preventDefault()
    var recipe_id = {recipe_id: window.location.pathname.split("/")[2]}
    postToGroceryList(recipe_id)
  })
}

function postToGroceryList(recipe){
  $.ajax({
    type: "POST",
    url: "/api/v1/grocery_lists",
    data: recipe
  }).done(function(grocery_list){
    debugger
    location.href = "/grocery_lists/" + grocery_list.id
  })
}