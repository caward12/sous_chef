var Categories = React.createClass({


  handleFilter(){
    this.props.handleFilterRecipes(this.props.id)
  },

  render() {
      return (
          <div>
            <button className="waves-effect waves-teal btn-flat" tabIndex="0" onClick={this.handleFilter}>{this.props.name}</button>
          </div>
      )
  }
});