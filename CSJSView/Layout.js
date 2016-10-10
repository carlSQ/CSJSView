var CSJSViewController = require('CSJSViewController');

class Layout extends CSJSViewController {
  
  constructor(initParameters) {
    super(initParameters)
  }
  
  get tableview() {
    return varForKey(this.nativeBridgeIdentifier, "tableview");
  }
  
  set tableview(value) {
    updateVarForKey(this.nativeBridgeIdentifier,"tableview",value);
  }
  
  viewDidLoad () {
    this.self.title = this.initParameters["key"];
    this.self.view.backgroundColor = JSColor.jsColor("EE88CC");
      Native_log(JSTableView);
    this.tableview = JSTableView.jsTableViewWithFrameAndStyle(this.self.view.frame,0);
    this.tableview.backgroundColor = JSColor.jsColor("CCDDEE");
    var that = this;
    this.tableview.jsDelegate = {
      numberOfRowsInSection :function (tableView, section) {
        return 50.0;
      },
      cellForRowAtIndexPath :function(tableView, indexPath) {
       var jsView = JSView.jsViewWithFrame({x:0,y:0,width:320,height:50});
        jsView.addSubview(JSImageView.imageViewWithImageFrame(JSImage.jsImageNamed("redActivity"),{x:10,y:10,width:22,height:22}));
        var title = JSLabel.labelWithTextFrame("carl shen", {x:50,y:15,width:100,height:22});
        jsView.addSubview(title);
        return jsView;
      },
      didSelectRowAtIndexPath: function() {
        
        that.self.navigationController.pushViewControllerAnimated(JSViewController.sourcePathModuleInitParams("Layout.js","Layout",{"key":"sq"}), true);
      }
    };
    this.self.view.addSubview(this.tableview);
  }
  
  viewWillAppear (animated) {
    Native_log("test viewWillAppear");
    Native_log(this);
 
  }
  
  viewDidAppear (animated) {
    Native_log("test viewDidAppear");
  }
  
  viewWillDisappear (animated) {
    Native_log("test viewWillDisappear");
  }
  
  viewDidDisappear (animated) {
    Native_log("test viewDidDisappear");
  }
  
  didReceiveMemoryWarning () {
    Native_log("test didReceiveMemoryWarning");
  }
}


module.exports = Layout;

ModulesRegistry.registerModule('Layout',Layout);

