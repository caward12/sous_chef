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
          <h2>{recipe.name}</h2>
          <h5>{recipe.instructions}</h5>
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