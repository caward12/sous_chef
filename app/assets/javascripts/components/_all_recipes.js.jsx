var AllRecipes = React.createClass({
  getInitialState() {
    return { recipes: [] }
  },

  componentDidMount() {
    $.getJSON('/api/v1/recipes', (response) => { this.setState({ recipes: response}) })
  },

  recipeCards(){
    return this.state.recipes.map(recipe => {
      return (<RecipeCard
        key={recipe.id}
        name={recipe.name}
        servings={recipe.servings}
        cookTime={recipe.cook_time}
        prepTime={recipe.prep_time}
        ingredients={recipe.ingredients}
        instructions={recipe.instructions}
        categories={recipe.categories}
        id={recipe.id}/>)
    })
  },
  render() {
      return (
        <div>
          {this.recipeCards()}
        </div>
      )
  }

})