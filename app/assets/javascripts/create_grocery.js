$(document).ready(function(){
  $("#new-grocery").on("click", function(event){
    event.preventDefault()
    var recipes =[]
    var recipeIds = Array.from($(".recipe-table input:checked")).forEach(function(recipe){
                      recipes.push(recipe.id)
                    })
    postToGroceryList({recipes: recipes})
  })
  // bindRecipewithGroceryList()
})

// function bindRecipewithGroceryList(){
//   $("#new-grocery").on("click", function(event){
//     debugger
//     event.preventDefault()
//     var recipe_id = {recipe_id: window.location.pathname.split("/")[2]}
//     postToGroceryList(recipe_id)
//   })
// }

function postToGroceryList(recipes){
  $.ajax({
    type: "POST",
    url: "/api/v1/grocery_lists",
    data: recipes
  }).done(function(grocery_list){
    location.href = "/grocery_lists/" + grocery_list.id
  })
}