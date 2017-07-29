var Recipe = React.createClass({
  getInitialState(){
    return {recipe: {},
            ingredients: [],
            categories: []}
  },

  componentDidMount(){
    $.getJSON('/api/v1/recipes/' + this.props.id, (response) => {
      this.setState({ recipe: response, ingredients: response.ingredients, categories: response.categories}) })
  },

  ingredientsList(){
    return this.state.ingredients.map(ingredient => {
      return (<Ingredient
        key={ingredient.id}
        name={ingredient.name}
        amount={ingredient.amount}
        id={ingredient.id}/>)
    })
  },

  categoriesList(){
    return this.state.categories.map(category => {
      return(<CategoryChip
        key={category.id}
        name={category.name}
        id={category.id}/>)
    })
  },

  render(){
    return (
      <div className="container">
        <div className="col m4 s12">
          <div className="col s9">
            <div className="card">
              <div className="card-content">
                <h4>{this.state.recipe.name}</h4>
                <p>Servings: {this.state.recipe.servings}</p>
                <p>Prep Time: {this.state.recipe.prep_time}</p>
                <p>Cook Time: {this.state.recipe.cook_time}</p>
                <br></br>
                <h5>Ingredients</h5>
                <div className="ingredients-list">
                  <ul>
                    {this.ingredientsList()}
                  </ul>
                </div>
                <br></br>
                <div className="instructions">
                  <h5>Instructions</h5>
                  {this.state.recipe.instructions}
                </div>
                <br></br>
                <div className="categories">
                  <h5>Categories</h5>
                  {this.categoriesList()}
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    )
  }
})