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

  handleEditClick() {
    debugger
    if (this.state.editable) {
        var name = this.state.name;
        var amount = this.state.amount;
        console.log('in handleEdit', this.state.editable, name, amount);
    }
    this.setState({ editable: !this.state.editable })
  },

  ingredientsList(){
    return this.state.ingredients.map(ingredient => {
      return (<Ingredient
        key={ingredient.id}
        name={ingredient.name}
        amount={ingredient.amount}
        handleEditClick={this.handleEditClick}
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

  onUpdate(){
    if(this.state.editable){
      var name = this.state.recipe.name
      var servings = this.state.recipe.servings
      var prepTime = this.state.recipe.prep_time
      var cookTime = this.state.recipe.cook_time
      var instructions = this.state.recipe.instructions
      var recipe = {name: name, servings: servings, prep_time: prepTime, cook_time: cookTime, instructions: instructions}
      this.handleUpdate(recipe)
    }
    this.setState({ editable: !this.state.editable})
  },

  handleUpdate(recipe){
    $.ajax({
      url: `/api/v1/recipes/${this.props.id}`,
      type: 'PUT',
      data: {recipe: recipe},
      success: () => {
        this.updateRecipe(recipe)
      }
    })
  },

  updateRecipe(recipe){
    this.setState({recipe: recipe})
  },

  render(){
    var name = this.state.editable ? <input type="text"
                                        onChange={(e) => this.setState({ recipe: {name: e.target.value,
                                                                                  servings: this.state.recipe.servings,
                                                                                  prep_time: this.state.recipe.prep_time,
                                                                                  cook_time: this.state.recipe.cook_time,
                                                                                  instructions: this.state.recipe.instructions}}) }
                                        defaultValue={this.state.recipe.name}/> : <h4>{this.state.recipe.name}</h4>
    var servings = this.state.editable ? <input type="text"
                                          onChange={(e) => this.setState({ recipe: {servings: e.target.value,
                                                                                    name: this.state.recipe.name,
                                                                                    prep_time: this.state.recipe.prep_time,
                                                                                    cook_time: this.state.recipe.cook_time,
                                                                                    instructions: this.state.recipe.instructions}}) }
                                          defaultValue={this.state.recipe.servings}/> : this.state.recipe.servings
    var prep_time = this.state.editable ? <input type="text"
                                            onChange={(e) => this.setState({ recipe: {prep_time: e.target.value,
                                                                                      name: this.state.recipe.name,
                                                                                      servings: this.state.recipe.servings,
                                                                                      cook_time: this.state.recipe.cook_time,
                                                                                      instructions: this.state.recipe.instructions}}) }
                                            defaultValue={this.state.recipe.prep_time}/> : this.state.recipe.prep_time
    var cook_time = this.state.editable ? <input type="text"
                                              onChange={(e) => this.setState({ recipe: {cook_time: e.target.value,
                                                                                        name: this.state.recipe.name,
                                                                                        servings: this.state.recipe.servings,
                                                                                        prep_time: this.state.recipe.prep_time,
                                                                                        instructions: this.state.recipe.instructions}}) }
                                              defaultValue={this.state.recipe.cook_time}/> : this.state.recipe.cook_time
    var instructions = this.state.editable ? <input type="text"
                                                onChange={(e) => this.setState({ recipe: {instructions: e.target.value,
                                                                                          name: this.state.recipe.name,
                                                                                          servings: this.state.recipe.servings,
                                                                                          prep_time: this.state.recipe.prep_time,
                                                                                          cook_time: this.state.recipe.cook_time}}) }
                                                defaultValue={this.state.recipe.instructions}/> : this.state.recipe.instructions
    return (
      <div className="container">
        <div className="col m4 s12">
          <div className="col s9">
            <div className="card">
              <div className="card-content">
                <p tabIndex="0"><button className="waves-effect waves-light btn red edit-recipe" onClick={this.onUpdate}>{this.state.editable ? 'Submit' : 'Edit Recipe' }</button></p>
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