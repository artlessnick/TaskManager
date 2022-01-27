/* eslint-disable no-use-before-define */
/* eslint-disable no-param-reassign */
/* eslint-disable no-underscore-dangle */
const _processKeys = function (convert, obj, options) {
  if (!_isObject(obj) || _isDate(obj) || _isRegExp(obj) || _isBoolean(obj) || _isFunction(obj) || _isFile(obj)) {
    return obj;
  }

  let output;
  let i = 0;
  let l = 0;

  if (_isArray(obj)) {
    output = [];
    // eslint-disable-next-line no-plusplus
    for (l = obj.length; i < l; i++) {
      output.push(_processKeys(convert, obj[i], options));
    }
  } else {
    output = {};
    // eslint-disable-next-line no-restricted-syntax
    for (const key in obj) {
      if (Object.prototype.hasOwnProperty.call(obj, key)) {
        output[convert(key, options)] = _processKeys(convert, obj[key], options);
      }
    }
  }
  return output;
};

// String conversion methods

const separateWords = function (string, options) {
  options = options || {};
  const separator = options.separator || '_';
  const split = options.split || /(?=[A-Z])/;

  return string.split(split).join(separator);
};

const camelize = function (string) {
  if (_isNumerical(string)) {
    return string;
  }
  // eslint-disable-next-line no-useless-escape
  string = string.replace(/[\-_\s]+(.)?/g, (match, chr) => (chr ? chr.toUpperCase() : ''));
  // Ensure 1st char is always lowercase
  return string.substr(0, 1).toLowerCase() + string.substr(1);
};

const decamelize = function (string, options) {
  return separateWords(string, options).toLowerCase();
};

// Utilities
// Taken from Underscore.js

const { toString } = Object.prototype;

const _isFunction = function (obj) {
  return typeof obj === 'function';
};
const _isObject = function (obj) {
  return obj === Object(obj);
};
const _isArray = function (obj) {
  return toString.call(obj) === '[object Array]';
};
const _isDate = function (obj) {
  return toString.call(obj) === '[object Date]';
};
const _isRegExp = function (obj) {
  return toString.call(obj) === '[object RegExp]';
};
const _isBoolean = function (obj) {
  return toString.call(obj) === '[object Boolean]';
};
const _isFile = function (obj) {
  return toString.call(obj) === '[object File]';
};

// Performant way to determine if obj coerces to a number
const _isNumerical = function (obj) {
  obj -= 0;
  // eslint-disable-next-line no-self-compare
  return obj === obj;
};

// Sets up function which handles processing keys
// allowing the convert function to be modified by a callback
const _processor = function (convert, options) {
  const callback = options && 'process' in options ? options.process : options;

  if (typeof callback !== 'function') {
    return convert;
  }

  // eslint-disable-next-line no-shadow
  return function (string, options) {
    return callback(string, convert, options);
  };
};

const camelizeKeys = (object, options) => _processKeys(_processor(camelize, options), object);
const decamelizeKeys = (object, options) => _processKeys(_processor(decamelize, options), object, options);

export { camelizeKeys as camelize, decamelizeKeys as decamelize };
