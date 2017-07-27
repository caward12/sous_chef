var AllRecipes = React.createClass({
  getInitialState() {
    return { recipes: [] }
  },

  componentDidMount() {
    $.getJSON('/api/v1/recipes', (response) => { this.setState({recipes: response}) });
  },
  render() {
    var recipes = this.state.recipes.map((recipe) =>{
      return (
        <div key={recipe.id}>
            <div className="col s12 m6">
              <div className="card">
                <div className="card-content">
                  <h3>{recipe.name}</h3>
                  <h6>{recipe.instructions}</h6>
                </div>
                <div className="card-action">

                </div>
              </div>
            </div>

          </div>
      )
    })
    return (
      <div>
      {recipes}
    </div>
    )
  }
});