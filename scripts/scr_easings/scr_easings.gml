function EaseLinear(_inputvalue, _outputmin, _outputmax, _inputmax) {
    return _outputmax * _inputvalue / _inputmax + _outputmin;
}

function EaseInQuad(_inputvalue, _outputmin, _outputmax, _inputmax) {
    _inputvalue /= _inputmax;
    return _outputmax * _inputvalue * _inputvalue + _outputmin;
}

function EaseOutQuad(_inputvalue, _outputmin, _outputmax, _inputmax) {
    _inputvalue /= _inputmax;
    return -_outputmax * _inputvalue * (_inputvalue - 2) + _outputmin;
}

function EaseInOutQuad(_inputvalue, _outputmin, _outputmax, _inputmax) {

    _inputvalue /= _inputmax * 0.5;

    if (_inputvalue < 1) {
        return _outputmax * 0.5 * _inputvalue * _inputvalue + _outputmin;
    }

    return _outputmax * -0.5 * (--_inputvalue * (_inputvalue - 2) - 1) + _outputmin;
}


function EaseInCubic(_inputvalue, _outputmin, _outputmax, _inputmax) {

    return _outputmax * power(_inputvalue / _inputmax, 3) + _outputmin;
}

function EaseOutCubic(_inputvalue, _outputmin, _outputmax, _inputmax) {

    return _outputmax * (power(_inputvalue / _inputmax - 1, 3) + 1) + _outputmin;
}

function EaseInOutCubic(_inputvalue, _outputmin, _outputmax, _inputmax) {

    _inputvalue /= _inputmax * 0.5;

    if (_inputvalue < 1) {
        return _outputmax * 0.5 * power(_inputvalue, 3) + _outputmin;
    }

    return _outputmax * 0.5 * (power(_inputvalue - 2, 3) + 2) + _outputmin;
}

function EaseInQuart(_inputvalue, _outputmin, _outputmax, _inputmax) {

    return _outputmax * power(_inputvalue / _inputmax, 4) + _outputmin;
}

function EaseOutQuart(_inputvalue, _outputmin, _outputmax, _inputmax) {

    return -_outputmax * (power(_inputvalue / _inputmax - 1, 4) - 1) + _outputmin;
}

function EaseInOutQuart(_inputvalue, _outputmin, _outputmax, _inputmax) {

    _inputvalue /= _inputmax * 0.5;

    if (_inputvalue < 1) {
        return _outputmax * 0.5 * power(_inputvalue, 4) + _outputmin;
    }

    return _outputmax * -0.5 * (power(_inputvalue - 2, 4) - 2) + _outputmin;
}

function EaseInQuint(_inputvalue, _outputmin, _outputmax, _inputmax) {

    return _outputmax * power(_inputvalue / _inputmax, 5) + _outputmin;
}

function EaseOutQuint(_inputvalue, _outputmin, _outputmax, _inputmax) {

    return _outputmax * (power(_inputvalue / _inputmax - 1, 5) + 1) + _outputmin;
}

function EaseInOutQuint(_inputvalue, _outputmin, _outputmax, _inputmax) {

    _inputvalue /= _inputmax * 0.5;

    if (_inputvalue < 1) {
        return _outputmax * 0.5 * power(_inputvalue, 5) + _outputmin;
    }

    return _outputmax * 0.5 * (power(_inputvalue - 2, 5) + 2) + _outputmin;
}

function EaseInSine(_inputvalue, _outputmin, _outputmax, _inputmax) {

    return _outputmax * (1 - cos(_inputvalue / _inputmax * (pi / 2))) + _outputmin;
}

function EaseOutSine(_inputvalue, _outputmin, _outputmax, _inputmax) {

    return _outputmax * sin(_inputvalue / _inputmax * (pi / 2)) + _outputmin;
}

function EaseInOutSine(_inputvalue, _outputmin, _outputmax, _inputmax) {

    return _outputmax * 0.5 * (1 - cos(pi * _inputvalue / _inputmax)) + _outputmin;
}

function EaseInCirc(_inputvalue, _outputmin, _outputmax, _inputmax) {

    _inputvalue /= _inputmax;
    return _outputmax * (1 - sqrt(1 - _inputvalue * _inputvalue)) + _outputmin;
}

function EaseOutCirc(_inputvalue, _outputmin, _outputmax, _inputmax) {

    _inputvalue = _inputvalue / _inputmax - 1;
    return _outputmax * sqrt(1 - _inputvalue * _inputvalue) + _outputmin;
}

function EaseInOutCirc(_inputvalue, _outputmin, _outputmax, _inputmax) {

    _inputvalue /= _inputmax * 0.5;

    if (_inputvalue < 1) {
        return _outputmax * 0.5 * (1 - sqrt(1 - _inputvalue * _inputvalue)) + _outputmin;
    }

    _inputvalue -= 2;
    return _outputmax * 0.5 * (sqrt(1 - _inputvalue * _inputvalue) + 1) + _outputmin;
}

function EaseInExpo(_inputvalue, _outputmin, _outputmax, _inputmax) {

    return _outputmax * power(2, 10 * (_inputvalue / _inputmax - 1)) + _outputmin;
}

function EaseOutExpo(_inputvalue, _outputmin, _outputmax, _inputmax) {

    return _outputmax * (-power(2, -10 * _inputvalue / _inputmax) + 1) + _outputmin;
}

function EaseInOutExpo(_inputvalue, _outputmin, _outputmax, _inputmax) {

    _inputvalue /= _inputmax * 0.5;

    if (_inputvalue < 1) {
        return _outputmax * 0.5 * power(2, 10 * --_inputvalue) + _outputmin;
    }

    return _outputmax * 0.5 * (-power(2, -10 * --_inputvalue) + 2) + _outputmin;
}

function EaseInElastic(_inputvalue, _outputmin, _outputmax, _inputmax) {

    var _s = 1.70158;
    var _p = 0;
    var _a = _outputmax;

    if (_inputvalue == 0 || _a == 0) {
        return _outputmin;
    }

    _inputvalue /= _inputmax;

    if (_inputvalue == 1) {
        return _outputmin + _outputmax;
    }

    if (_p == 0) {
        _p = _inputmax * 0.3;
    }

    if (_a < abs(_outputmax)) {
        _a = _outputmax;
        _s = _p * 0.25;
    } else {
        _s = _p / (2 * pi) * arcsin(_outputmax / _a);
    }

    return -(_a * power(2, 10 * (--_inputvalue)) * sin((_inputvalue * _inputmax - _s) * (2 * pi) / _p)) + _outputmin;
}

function EaseOutElastic(_inputvalue, _outputmin, _outputmax, _inputmax) {

    var _s = 1.70158;
    var _p = 0;
    var _a = _outputmax;

    if (_inputvalue == 0 || _a == 0) {
        return _outputmin;
    }

    _inputvalue /= _inputmax;

    if (_inputvalue == 1) {
        return _outputmin + _outputmax;
    }

    if (_p == 0) {
        _p = _inputmax * 0.3;
    }

    if (_a < abs(_outputmax)) {
        _a = _outputmax;
        _s = _p * 0.25;
    } else {
        _s = _p / (2 * pi) * arcsin(_outputmax / _a);
    }

    return _a * power(2, -10 * _inputvalue) * sin((_inputvalue * _inputmax - _s) * (2 * pi) / _p) + _outputmax + _outputmin;
}

function EaseInOutElastic(_inputvalue, _outputmin, _outputmax, _inputmax) {

    var _s = 1.70158;
    var _p = 0;
    var _a = _outputmax;

    if (_inputvalue == 0 || _a == 0) {
        return _outputmin;
    }

    _inputvalue /= _inputmax * 0.5;

    if (_inputvalue == 2) {
        return _outputmin + _outputmax;
    }

    if (_p == 0) {
        _p = _inputmax * (0.3 * 1.5);
    }

    if (_a < abs(_outputmax)) {
        _a = _outputmax;
        _s = _p * 0.25;
    } else {
        _s = _p / (2 * pi) * arcsin(_outputmax / _a);
    }

    if (_inputvalue < 1) {
        return -0.5 * (_a * power(2, 10 * (--_inputvalue)) * sin((_inputvalue * _inputmax - _s) * (2 * pi) / _p)) + _outputmin;
    }

    return _a * power(2, -10 * (--_inputvalue)) * sin((_inputvalue * _inputmax - _s) * (2 * pi) / _p) * 0.5 + _outputmax + _outputmin;
}

function EaseInBack(_inputvalue, _outputmin, _outputmax, _inputmax) {

    var _s = 1.70158;

    _inputvalue /= _inputmax;
    return _outputmax * _inputvalue * _inputvalue * ((_s + 1) * _inputvalue - _s) + _outputmin;
}

function EaseOutBack(_inputvalue, _outputmin, _outputmax, _inputmax) {

    var _s = 1.70158;

    _inputvalue = _inputvalue / _inputmax - 1;
    return _outputmax * (_inputvalue * _inputvalue * ((_s + 1) * _inputvalue + _s) + 1) + _outputmin;
}

function EaseInOutBack(_inputvalue, _outputmin, _outputmax, _inputmax) {

    var _s = 1.70158;

    _inputvalue = _inputvalue / _inputmax * 2

    if (_inputvalue < 1) {
        _s *= 1.525;
        return _outputmax * 0.5 * (_inputvalue * _inputvalue * ((_s + 1) * _inputvalue - _s)) + _outputmin;
    }

    _inputvalue -= 2;
    _s *= 1.525

    return _outputmax * 0.5 * (_inputvalue * _inputvalue * ((_s + 1) * _inputvalue + _s) + 2) + _outputmin;
}

function EaseInBounce(_inputvalue, _outputmin, _outputmax, _inputmax) {

    return _outputmax - EaseOutBounce(_inputmax - _inputvalue, 0, _outputmax, _inputmax) + _outputmin
}

function EaseOutBounce(_inputvalue, _outputmin, _outputmax, _inputmax) {

    _inputvalue /= _inputmax;

    if (_inputvalue < 1 / 2.75) {
        return _outputmax * 7.5625 * _inputvalue * _inputvalue + _outputmin;
    } else
    if (_inputvalue < 2 / 2.75) {
        _inputvalue -= 1.5 / 2.75;
        return _outputmax * (7.5625 * _inputvalue * _inputvalue + 0.75) + _outputmin;
    } else
    if (_inputvalue < 2.5 / 2.75) {
        _inputvalue -= 2.25 / 2.75;
        return _outputmax * (7.5625 * _inputvalue * _inputvalue + 0.9375) + _outputmin;
    } else {
        _inputvalue -= 2.625 / 2.75;
        return _outputmax * (7.5625 * _inputvalue * _inputvalue + 0.984375) + _outputmin;
    }
}

function EaseInOutBounce(_inputvalue, _outputmin, _outputmax, _inputmax) {

    if (_inputvalue < _inputmax * 0.5) {
        return (EaseInBounce(_inputvalue * 2, 0, _outputmax, _inputmax) * 0.5 + _outputmin);
    }

    return (EaseOutBounce(_inputvalue * 2 - _inputmax, 0, _outputmax, _inputmax) * 0.5 + _outputmax * 0.5 + _outputmin);
}