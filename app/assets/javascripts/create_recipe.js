$(document).ready(function(){
  $('.create-ingredients').hide()
  $('.create-instructions').hide()
  $('.create-categories').hide()
  bindAddIngredientswithForm()
  bindAddInstructionswithForm()
  bindAddCategorieswithForm()
  bindCompleteRecipewithForm()
  bindAddAnotherIngredientwithPartial()
  bindAddAnotherCategorywithPartial()
})

function bindCompleteRecipewithForm(){
  $('.create-categories .complete-recipe').on("click", function(event){
    event.preventDefault()
    createCategories()
  })
}

function createCategories(){
  var recipe = $('.create-categories').attr('id')
  var categoryIds =[]
  var existingCategories = Array.from($('.existing-categories input:checked')).forEach(function(category){
                              categoryIds.push(category.id)
                            })
  var arr = []
  Array.from($('.categories .category-fields')).forEach(function(row){
    var data =  {}
       data["name"]= $(row).children()[0].children[0].value,
       arr.push(data)
  })
  var categories = {
    recipe_id: recipe,
    categories: arr
  }

  if(categoryIds.length > 0 && arr[0].name.length > 0){
    postRecipeCategories(recipe, categoryIds)
    postCategories(recipe, categories)

  }
  else if (categoryIds.length > 0){
    postRecipeCategories(recipe, categoryIds)

  }
  else if (arr[0].name.length > 0){
    postCategories(recipe, categories)

  }
  else {
    location.href = "/recipes/" + recipe
  }

}

function postCategories(recipe, categories){
  $.ajax({
    type: "POST",
    url: "/api/v1/categories",
    data: categories
  }).then(function(data){
          location.href = "/recipes/" + recipe
        })
}

function postRecipeCategories(recipe, categoryIds){
  $.ajax({
    type: "POST",
    url: "/api/v1/recipe_categories",
    data: {
      recipe_id: recipe,
      categories: categoryIds
    }
  }).then(function(data){
          location.href = "/recipes/" + recipe
        })
}

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
    url: "/api/v1/recipes/" + recipe,
    data: instructions
  }).then(function(updatedRecipe){
    $('.create-instructions').hide()
    if ($('.create-categories').is(":hidden")){
      $.ajax({
        type: "GET",
        url: "/api/v1/categories",
      }).then(function(categories){
        var table = $('.exist-cat tbody')
        var tableRow = document.createElement('tr')
        categories.forEach(function(category){
          $(tableRow).append("<td><input type='checkbox' id=" + category.id + " /><label for=" + category.id + ">" + category.name + "</label></td>")
          if (category.id % 3 === 0){
            table.append(tableRow)
            tableRow = document.createElement('tr')
          }
        })
      })
    }
     $('.create-categories').show()
     $('.create-categories').attr('id', updatedRecipe.id)
  })
}

function bindAddAnotherCategorywithPartial(){
  $('.create-categories #addNewCategory').on("click", function(event){
    $(".categories").append($("#new_categories_form").html())
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
    var arr = []
    Array.from($('.ingredients .ingredient-fields')).forEach(function(row){
      var data =  {}
         data["name"]= $(row).children()[0].children[0].value,
         data["amount"]= $(row).children()[1].children[0].value
         arr.push(data)
    })

    if (arr[0].name.length ==0 || arr[0].amount.length == 0){
      alert("you must have at least one ingredient with name and amount")
    } else {
      createIngredients(arr)
    }
  })
}

function createIngredients(arr){
  var recipe = $('.create-ingredients').attr('id')

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
    $('.create-instructions').attr('id', newIngredients[0].recipe_id)
  })
}
function bindAddIngredientswithForm(){
  $('.create-recipe .add-ingredients').on("click", function(event){
    event.preventDefault()
    if ($("#recipe_name").val().length ==0){
      alert("You must have a recipe name")
    }else {
      createRecipe()
    }
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
            $('.create-ingredients').attr('id', newRecipe.id)
          })


}
