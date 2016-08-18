var CSJSViewController = require('CSJSViewController');

class Layout extends CSJSViewController {
  
  viewDidLoad () {

    Native_log(CSJSViewController);

  }
  
  viewWillAppear (animated) {
    Native_log("test viewWillAppear");
    this.self.title = this.initParameters["key"];
    Native_log(this.self.view);
    Native_log(this.self.title);
    this.self.view.backgroundColor = JSColor.jsColor("EE88CC");
    Native_log(this.self.view.backgroundColor);
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

