# cbSpur

Implements Spur.us Api for Coldbox Coldfusion.
See https://spur.us/app/context/docs

The supur offers structured information on IP addresses and helps to indentify Vpn Endpoints, Geo Fraud, Residential Proxies, Device Behaviors

## Installation

You will need a Spur.us Account to work with this API
Attention this Api is commercial, but a one month free trial is offered


This API can be installed as standalone or as a ColdBox Module.  Either approach requires a simple CommandBox command:

```
box install cbSpur
```

Then follow either the standalone or module instructions below.

### Standalone

This API will be installed into a directory called `cbSpur` and then:

```
     c = createObject('component','models.spurclient');
     c.init( ContextApiToken = 'YOUR TOKEN GOES HERE');

     c.getContext('95.191.237.191');
```

### ColdBox Module

This package also is a ColdBox module as well.  The module can be configured by adding `ContextApiToken` in your application configuration file: `config/Coldbox.cfc` with the following settings:

```

		moduleSettings : {
			'cbSpur' : {
                 // Your Spur ContextApiToken Key
                ContextApiToken = "",
            }

    };
```

Then you can leverage the API CFC via the injection DSL: `SpurClient@cbSpur`

## Usage

```
/**
* A normal ColdBox Event Handler
*/
component{
    property name="spur" inject="SpurClient@cbSpur";

    function index(event,rc,prc){

        // returns struct
        var t=spur.getContext('95.191.237.191');
        writeDump(t);

        abort;
    }
}
```

## Written by
www.akitogo.com

## Disclaimer
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.