var Recipe = React.createClass({
  getInitialState(){
    return {recipe: {},
            ingredients: [],
            categories: [],
            editable: false}
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

  handleEdit(){
    this.setState({editable: true})
    console.log("we're editing");
  },

  render(){
    var name = this.state.editable ? <input type="text" defaultValue={this.state.recipe.name}/> : <h4>{this.state.recipe.name}</h4>
    var servings = this.state.editable ? <input type="text" defaultValue={this.state.recipe.servings}/> : this.state.recipe.servings
    var prep_time = this.state.editable ? <input type="text" defaultValue={this.state.recipe.prep_time}/> : this.state.recipe.prep_time
    var cook_time = this.state.editable ? <input type="text" defaultValue={this.state.recipe.cook_time}/> : this.state.recipe.cook_time
    var instructions = this.state.editable ? <input type="text" defaultValue={this.state.recipe.instructions}/> : this.state.recipe.instructions
    return (
      <div className="container">
        <div className="col m4 s12">
          <div className="col s9">
            <div className="card">
              <div className="card-content">
                <p><button className="waves-effect waves-light btn red edit-recipe" onClick={this.handleEdit}>Edit</button></p>
                {name}
                <p>Servings: {servings}</p>
                <p>Prep Time: {prep_time}</p>
                <p>Cook Time: {cook_time}</p>
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
                  {instructions}
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