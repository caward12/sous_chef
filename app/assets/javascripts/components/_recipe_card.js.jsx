var RecipeCard = React.createClass({
  getInitialState() {
    return { categories: [] }
  },

  componentDidMount(){
    this.setState({ categories: this.props.categories})
  },

  categoryChips(){
    return this.state.categories.map(category => {
      return (<CategoryChip
          key={category.id}
          name={category.name}
          id={category.id}/>)
    })
  },

  render(){
    return (
      <div className="col s12 m6">
        <div className="card">
          <div className="card-content">
            <h5>{this.props.name}</h5>
            <h6>{this.props.instructions}</h6>
          </div>
          <div className="card-action">
          {this.categoryChips()}
          </div>
        </div>
      </div>
    )
  }
})