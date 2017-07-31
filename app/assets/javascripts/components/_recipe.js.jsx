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
    var ingredState = this.state.ingredients
    return this.state.ingredients.map((ingredient, index) => {
      return (
        this.state.editable ? <li key={ingredient.id}>
                              <input name="ingredient-amount" type='text'
                                     onChange={ (e) => this.setState({ingredients: ingredState.slice(0, index).concat(ingredState.slice(index +1, ingredState.length)).concat({amount: e.target.value,
                                                                                      name: ingredient.name,
                                                                                      id: ingredient.id})
                                                                                    }) }
                                     defaultValue={ingredient.amount} />
                                   <input  name="ingredient-name" type='text'
                                     onChange={ (e) => this.setState({ingredients: ingredState.slice(0, index).concat(ingredState.slice(index +1, ingredState.length)).concat({ name: e.target.value,
                                                                                      amount: ingredient.amount,
                                                                                      id: ingredient.id})
                                                                                    }) }
                                     defaultValue={ingredient.name} />

                              </li> : <li key={ingredient.id}> {ingredient.amount} {ingredient.name}</li>
      )
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
      var ingredients = this.state.ingredients
      var recipe = {name: name, servings: servings, prep_time: prepTime, cook_time: cookTime, instructions: instructions}
      this.handleUpdate(recipe)
      this.handleUpdateIngredients(ingredients)
    }
    this.setState({ editable: !this.state.editable})
  },

  handleUpdateIngredients(ingredients){
    ingredients.forEach(ingredient => {
      $.ajax({
        url: `/api/v1/ingredients/${ingredient.id}`,
        type: 'PUT',
        data: {ingredient: ingredient},
        success: ()=>{
          this.updateIngredients()
        }
      })
    })
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

  updateIngredients(){
    $.getJSON('/api/v1/recipes/' + this.props.id, (response) => {
      this.setState({ingredients: response.ingredients}) })
  },

  updateRecipe(recipe){
    this.setState({recipe: recipe})
  },

  render(){
    var name = this.state.editable ? <input type="text" name="recipe-name"
                                        onChange={(e) => this.setState({ recipe: {name: e.target.value,
                                                                                  servings: this.state.recipe.servings,
                                                                                  prep_time: this.state.recipe.prep_time,
                                                                                  cook_time: this.state.recipe.cook_time,
                                                                                  instructions: this.state.recipe.instructions}}) }
                                        defaultValue={this.state.recipe.name}/> : <h4>{this.state.recipe.name}</h4>
    var servings = this.state.editable ? <input type="text" name="recipe-servings"
                                          onChange={(e) => this.setState({ recipe: {servings: e.target.value,
                                                                                    name: this.state.recipe.name,
                                                                                    prep_time: this.state.recipe.prep_time,
                                                                                    cook_time: this.state.recipe.cook_time,
                                                                                    instructions: this.state.recipe.instructions}}) }
                                          defaultValue={this.state.recipe.servings}/> : this.state.recipe.servings
    var prep_time = this.state.editable ? <input type="text" name="recipe-prep"
                                            onChange={(e) => this.setState({ recipe: {prep_time: e.target.value,
                                                                                      name: this.state.recipe.name,
                                                                                      servings: this.state.recipe.servings,
                                                                                      cook_time: this.state.recipe.cook_time,
                                                                                      instructions: this.state.recipe.instructions}}) }
                                            defaultValue={this.state.recipe.prep_time}/> : this.state.recipe.prep_time
    var cook_time = this.state.editable ? <input type="text" name="recipe-cook"
                                              onChange={(e) => this.setState({ recipe: {cook_time: e.target.value,
                                                                                        name: this.state.recipe.name,
                                                                                        servings: this.state.recipe.servings,
                                                                                        prep_time: this.state.recipe.prep_time,
                                                                                        instructions: this.state.recipe.instructions}}) }
                                              defaultValue={this.state.recipe.cook_time}/> : this.state.recipe.cook_time
    var instructions = this.state.editable ? <input type="text" name="recipe-instructions"
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