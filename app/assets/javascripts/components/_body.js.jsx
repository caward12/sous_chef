var Body = React.createClass({
  render() {
    return (
      <div className="row">
        <div className="col s3 recipe-categories">
          <Categories />
        </div>
        <div className="col s9 all-recipes">
          <AllRecipes />
        </div>
      </div>
    )
  }
});