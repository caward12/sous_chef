$(document).ready(function(){
  $('.create-ingredients').hide()
  $('.create-instructions').hide()
  $('.create-categories').hide()
  bindAddIngredientswithForm()
  bindAddInstructionswithForm()
  bindAddCategorieswithForm()
  bindAddAnotherIngredientwithPartial()
})

function bindAddCategorieswithForm(){
  $('.create-instructions .add-categories').on("click", function(event){
    event.preventDefault()
    createInstructions()
  })
}

function createInstructions(){
  var recipe = $('.create-instructions').attr('id')
  var instructions = {recipe: {instructions: $('textarea#instructions').val()}}

  $.ajax({
    type: "PUT",
    url: `/api/v1/recipes/${recipe}`,
    data: instructions
  }).then(function(updatedRecipe){
    $('.create-instructions').hide()
    if ($('.create-categories').is(":hidden")){
      $('.create-categories').show()
    }
    $('.create-categories').attr('id', `${updatedRecipe.id}`)
  })
}

function bindAddAnotherIngredientwithPartial(){
  $('.create-ingredients #addNewIngredient').on("click", function(event){
    $(".ingredients").append($("#new_ingredients_form").html())
  })
}

function bindAddInstructionswithForm(){
  $('.create-ingredients .add-instructions').on("click", function(event){
    event.preventDefault()

    createIngredients()
  })
}

function createIngredients(){
  var recipe = $('.create-ingredients').attr('id')
  var arr = []
  Array.from($('.ingredients .ingredient-fields')).forEach(function(row){
    var data =  {}
       data["name"]= $(row).children()[0].children[0].value,
       data["amount"]= $(row).children()[1].children[0].value
       arr.push(data)
  })
  var ingredients = {
    recipe_id: recipe,
    ingredients: arr
  }
  $.ajax({
    type: "POST",
    url: "/api/v1/ingredients",
    data: ingredients
  }).then(function(newIngredients){
    $('.create-ingredients').hide()
    if ($('.create-instructions').is(":hidden")){
      $('.create-instructions').show()
    }
    $('.create-instructions').attr('id', `${newIngredients[0].recipe_id}`)
  })
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
