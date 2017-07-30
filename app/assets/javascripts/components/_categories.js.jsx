var Categories = React.createClass({


  handleFilter(){
    // console.log(this.props);
    this.props.handleFilterRecipes(this.props.id)
  },

  render() {
      return (
        <div className="categories-list">
          <h5 tabIndex="0" onClick={this.handleFilter}>{this.props.name}</h5>
        </div>
      )
  }
});