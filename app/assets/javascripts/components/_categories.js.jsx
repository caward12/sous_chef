var Categories = React.createClass({


  handleFilter(){
    // console.log(this.props);
    this.props.handleFilterRecipes(this.props.id)
  },

  render() {
      return (
        <div>
          <h5 onClick={this.handleFilter}>{this.props.name}</h5>
        </div>
      )
  }
});