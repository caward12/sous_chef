$(document).ready(function(){
  $('.create-ingredients').hide()
  bindAddIngredientswithForm()
  bindAddInstructionswithFrom()
})

function bindAddInstructionswithFrom(){
  $('.create-recipe .add-instructions').on("click", function(event){
    event.preventDefault()
    createIngredients()
  })
}

function createIngredients(){
  var ingredients = {
    ingredients: {
      
    }
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
            $('.create-ingredients').data("recipe", newRecipe.id)
            if ($('.create-ingredients').is(":hidden")){
              $('.create-ingredients').show()
            }
          })


}
