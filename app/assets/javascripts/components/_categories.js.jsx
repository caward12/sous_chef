var Categories = React.createClass({
  getInitialState() {
    return { categories: [] }
  },

  componentDidMount() {
    $.getJSON('/api/v1/categories', (response) => { this.setState({categories: response}) });
  },
  render() {
    var categories = this.state.categories.map((category) =>{
      return (
        <div key={category.id}>
          <h5>{category.name}</h5>
        </div>
      )
    })
    return (
      <div>
        {categories}
      </div>
    )
  }
});