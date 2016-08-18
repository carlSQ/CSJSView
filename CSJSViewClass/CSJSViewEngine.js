var global = this;

(function() {



    var modules = {};
    function Module (path) {
      return {
          path: path,
          load: nativeLoadJSModule,
          exports: {},
          loaded: false
      }
    }

    function require(path) {
        var cacheModule = modules[path];
        if (cacheModule) {
            return cacheModule.exports;
        }

        return requireImpl(path);
    }

    function requireImpl(path) {

        var module = Module(path);
        modules[path] = module;
        try {

            module.load.call(global,global,require, module, module.exports, path);
            module.loaded = true;

         } catch(e) {
            module.loaded = false;
            delete modules[path];
        }

        return module.exports;
    }

    global.require = require;

    var registerModules = {};
    ModulesRegistry = {

        registerModule: function(moduleName, module) {
            registerModules[moduleName] = {
                run: function(initParameters) {
                      return new module(initParameters);
                     }
            };
         },
        getModuleNames: function() {
            return Object.keys(registerModules);
        },

        runApplication: function(moduleName, path, initParameters) {
            if (registerModules[moduleName]) {
                registerModules[moduleName].run(initParameters);
            } else {
                requireImpl(path);
               return registerModules[moduleName].run(initParameters);
            }
        }

    };

    global.ModulesRegistry = ModulesRegistry;


    class CSJSViewController {

        constructor(initParameters) {
            this.initParameters = initParameters;
        }

        viewDidLoad() {
        }

        viewWillAppear(animated) {
        }

        viewDidAppear(animated) {
        }

        viewWillDisappear(animated) {
        }

        viewDidDisappear(animated) {
        }

        didReceiveMemoryWarning() {
        }

    }
    var module = {
                    path: 'CSJSViewController',
                    exports: CSJSViewController,
                    loaded: true
                  };

    modules['CSJSViewController'] = module;

 
}) ();

