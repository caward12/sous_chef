$(document).ready(function(){
  $('.create-ingredients').hide()
  bindAddIngredientswithForm()
  bindAddInstructionswithFrom()
  bindAddAnotherIngredientwithPartial()
})

function bindAddAnotherIngredientwithPartial(){
  $('.create-ingredients #addNewIngredient').on("click", function(event){
    $(".ingredients").append($("#new_ingredients_form").html())
  })
}

function bindAddInstructionswithFrom(){
  $('.create-ingredients .add-instructions').on("click", function(event){
    event.preventDefault()
    // getIngredients()
    createIngredients()
  })
}

function getIngredients(){
return
}

function createIngredients(){
  var arr = []
  Array.from($('.ingredients .ingredient-fields')).forEach(function(row){
    var data =  {}
       data["name"]= $(row).children()[0].children[0].value,
       data["amount"]= $(row).children()[1].children[0].value
       arr.push(data)
            })
  var ingredients = {
    ingredients: {arr}
  }


}
function bindAddIngredientswithForm(){
  $('.create-recipe .add-ingredients').on("click", function(event){
    event.preventDefault()
    createRecipe()
  })
}

function createRecipe(){
  var recipeData = {
    recipe: {
      name: $("#recipe_name").val(),
      servings: $("#recipe_servings").val(),
      cook_time: $("#recipe_cook_time").val(),
      prep_time: $("#recipe_prep_time").val()
    }
  }
  $.post("/api/v1/recipes",recipeData)
        .then(function(newRecipe) {
            $('.create-recipe').hide()
            if ($('.create-ingredients').is(":hidden")){
              $('.create-ingredients').show()
            }
            $('.create-ingredients').attr('id', `${newRecipe.id}`)
          })


}
