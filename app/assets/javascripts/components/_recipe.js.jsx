var Recipe = React.createClass({
  getInitialState(){
    // debugger
    return {recipe: []}
  },

  componentDidMount(){
    // $.getJSON('/api/v1/recipes/' + this.props.id, (response) => {
      this.setState({ recipe: this.props.recipe})
    // })
  },

  render(){
    return (
      <h5>{this.state.recipe.name}</h5>
    )
  }
})