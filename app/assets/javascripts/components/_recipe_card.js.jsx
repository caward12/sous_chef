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
            <h4><a href={'/recipes/' + this.props.id}>{this.props.name}</a></h4>
          </div>
          <div className="card-action">
          {this.categoryChips()}
          </div>
        </div>
      </div>
    )
  }
})