docpad-plugin-persona
=====================

### The [express-persona](http://jbuck.github.com/express-persona/ "http://jbuck.github.com/express-persona/") npm module as a [docpad](http://docpad.org/ "http://docpad.org/") plugin.

[Mozilla Persona](https://developer.mozilla.org/en-US/docs/Persona?redirectlocale=en-US&redirectslug=BrowserID "https://developer.mozilla.org/en-US/docs/Persona?redirectlocale=en-US&redirectslug=BrowserID"), formerly called BrowserID, is self described as: "a cross-browser login system for the Web that's easy to use and easy to deploy. It works on all major browsers, and you can get started today."

This docpad plugin uses [jsdom](https://github.com/tmpvar/jsdom "https://github.com/tmpvar/jsdom") to [query](https://developer.mozilla.org/en-US/docs/DOM/Document.querySelectorAll "https://developer.mozilla.org/en-US/docs/DOM/Document.querySelectorAll") the DOM for "#persona-btn" on the [renderDocument](http://docpad.org/docs/events "http://docpad.org/docs/events") docpad event. If it finds it, it'll create a script tag that is the express-persona script:

```javascript
var loginButton = document.querySelectorAll('.persona-btn');

loginButton.addEventListener("click", function() {
  navigator.id.get(function(assertion) {
    if (!assertion) {
      return;
    }

    var xhr = new XMLHttpRequest();
    xhr.open("POST", "/persona/verify", true);
    xhr.setRequestHeader("Content-Type", "application/json");
    xhr.addEventListener("loadend", function(e) {
      try {
        var data = JSON.parse(this.response);
        if (data.status === "okay") {
          // the email address the user logged in with
          console.log(data.email);
        } else {
          console.log("Login failed because " + data.reason);
        }
      } catch (ex) {
        // oh no, we didn't get valid JSON from the server
      }
    }, false);
    xhr.send(JSON.stringify({
      assertion: assertion
    }));
  });
}, false);
```

___


##### The "Sign in" button comes in three color options:
Along with a script tag being created, a link tag will be created as well linking the appripiate css file to create a CSS3 Sign In button.
<table>
<tr>
    <td>.class</td>
    <td>Button</td>
    <td>.css file</td>
</tr>
<tr>
    <td>.persona-btn</td>
    <td><img src="https://developer.mozilla.org/files/3969/plain_sign_in_blue.png" alt="persona sign in blue"/></td>
    <td><a href="https://github.com/mikeumus/docpad-plugin-persona/blob/master/src/styles/persona-btn.css" title="https://github.com/mikeumus/docpad-plugin-persona/blob/master/src/styles/persona-btn.css">persona-btn.css</a></td>
</tr>
<tr>
	<td>" + .dark</td>
	<td><img src="https://developer.mozilla.org/files/3967/plain_sign_in_black.png" alt="persona sign in dark"/></td>
	<td><a href="https://github.com/mikeumus/docpad-plugin-persona/blob/master/src/styles/persona-dark-btn.css" title="https://github.com/mikeumus/docpad-plugin-persona/blob/master/src/styles/persona-dark-btn.css">persona-dark-btn.css</a></td>
<tr>
	<td>" + .orange</td>
	<td><img src="https://developer.mozilla.org/files/3971/plain_sign_in_red.png" alt="persona sign in orange"/></td>
	<td><a href="https://github.com/mikeumus/docpad-plugin-persona/blob/master/src/styles/persona-orange-btn.css" title="https://github.com/mikeumus/docpad-plugin-persona/blob/master/src/styles/persona-orange-btn.css">persona-orange-btn.css</a></td>
</table>

___


##### Dependencies
<table>
<tr>
    <td><a href="https://npmjs.org/package/jsdom">jsdom.js</a></td>
    <td>0.2.x</td>
</tr>
<tr>
    <td><a href="https://npmjs.org/package/express">express</a></td>
    <td>~3.0.6</td>
</tr>
<tr>
    <td><a href="https://npmjs.org/package/express-persona">express-persona</a></td>
    <td>0.0.7</td>
</tr>
<tr>
    <td><a href="https://npmjs.org/package/bal-util">bal-util</a></td>
    <td>&gt;=1.13.8 &lt;1.14</td>
</tr>
</table>

## License
Licensed under the incredibly [permissive](http://en.wikipedia.org/wiki/Permissive_free_software_licence) [MIT License](http://creativecommons.org/licenses/MIT/)
<br/>Copyright &copy; 2013 [MDM Inc](http://mdm.cm/ "http://mdm.cm/")