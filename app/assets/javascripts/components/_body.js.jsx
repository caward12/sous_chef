var Body = React.createClass({
  getInitialState() {
    return { categories: [],
             recipes: [] }
  },

  componentDidMount() {
    $.getJSON('/api/v1/categories', (response) => { this.setState({categories: response}) })
    $.getJSON('/api/v1/recipes', (response) => { this.setState({ recipes: response}) })
  },

  filterRecipes(id){
    let recipes = []
    this.state.recipes.filter(recipe => {
     recipe.categories.forEach(category => {
        if(category.id == id){
          recipes.push(recipe)
        }
      })
    })
    this.setState({recipes: recipes});
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

  categoriesList(){
    return this.state.categories.map(category => {
      return (<Categories
        key={category.id}
        name={category.name}
        handleFilterRecipes={this.filterRecipes}
        id={category.id}/>)
    })
  },
  render() {
    return (
      <div className="row">
        <div className="col s3 recipe-categories">
          {this.categoriesList()}
          <h5><a href="/recipes">All Recipes</a></h5>
        </div>
        <div className="col s9 all-recipes">
          {this.recipeCards()}
        </div>
      </div>
    )
  }
});