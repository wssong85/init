(function(c) {
    var e = {
        dateFormat: "yy-mm-dd",
        showButtonPanel: true,
        showOtherMonths: true,
        constrainInput: false,
        clearText: "Clear",
        showMonthAfterYear: true,
        changeMonth: true,
        changeYear: true,
        yearRange: "c-100:c+100",
        beforeShow: a,
        onChangeMonthYear: b,
        onClose: function(n, s) {
            var p = s.id;
            if (p) {
                var g = s.settings["isBeginElement"],
                    k = s.settings["oppositeElement"],
                    r = s.settings["isEndElement"];
                if (g) {
                    var l;
                    if (n != "UKUK-UK-UK") {
                        l = n.replace(/UK/g, "01")
                    }
                    var i = k ? k.call(this) : [];
                    for (var h = 0, q = i.length; h < q; h++) {
                        var j = i.eq(h),
                            m = j.val();
                        j.datepicker("option", "minDate", l);
                        if (!l || (function() {
                                var u = m.split("-"),
                                    t = l.split("-");
                                for (var o = 0; o < 3; o++) {
                                    if (/UK/g.test(u[o]) || u[o] < t[o]) {
                                        return true
                                    }
                                }
                                return false
                            }())) {
                            j.val(m)
                        }
                    }
                } else {
                    if (r) {
                        var f;
                        if (n != "UKUK-UK-UK") {
                            if (/^\d\d\d\d-UK-UK$/.test(n)) {
                                f = n.replace(/UK-UK$/, "12-31")
                            } else {
                                if (/^\d\d\d\d-\d\d-UK$/.test(n)) {
                                    f = n.replace(/^(\d\d\d\d)-(\d\d)-UK$/, function() {
                                        var u = arguments,
                                            t = parseInt(u[1], 10),
                                            v = parseInt(u[2], 10),
                                            o;
                                        switch (v) {
                                            case 1:
                                            case 3:
                                            case 5:
                                            case 7:
                                            case 8:
                                            case 10:
                                            case 12:
                                                o = 31;
                                                break;
                                            case 4:
                                            case 6:
                                            case 9:
                                            case 11:
                                                o = 30;
                                                break;
                                            case 2:
                                                o = (t % 4 == 0 ? 29 : 28);
                                                break
                                        }
                                        return [u[1], u[2], o].join("-")
                                    })
                                } else {
                                    f = n
                                }
                            }
                        }
                        var i = k ? k.call(this) : [];
                        for (var h = 0, q = i.length; h < q; h++) {
                            var j = i.eq(h),
                                m = j.val();
                            j.datepicker("option", "maxDate", f);
                            if (!f || (function() {
                                    var u = m.split("-"),
                                        t = f.split("-");
                                    for (var o = 0; o < 3; o++) {
                                        if (/UK/g.test(u[o]) || u[o] > t[o]) {
                                            return true
                                        }
                                    }
                                    return false
                                }())) {
                                j.val(m)
                            }
                        }
                    }
                }
            }
            c(s.input).trigger("change.datepicker")
        }
    };

    function a(i, j) {
        var f = i.value;
        if (/^(\d\d\d\d|UKUK)-(\d\d|UK)-UK$/i.test(f)) {
            var l = f.split("-"),
                h = new Date();
            if (l[0] == "UKUK") {
                l[0] = "" + h.getFullYear()
            }
            if (l[1] == "UK") {
                var k = h.getMonth() + 1;
                l[1] = (k < 10 ? "0" : "") + k
            }
            if (l[2] == "UK") {
                var g = h.getDate();
                l[2] = (g < 10 ? "0" : "") + g
            }
            c(i).datepicker("setDate", l.join("-"));
            setTimeout(function() {
                i.value = f;
                d(i, j.drawYear, j.drawMonth + 1, j);
                if (!i.readOnly) {
                    i.value = f.replace(/[^0-9]/g, "")
                }
            }, 1)
        } else {
            setTimeout(function() {
                d(i, j.drawYear, j.drawMonth + 1, j);
                if (!i.readOnly) {
                    i.value = f.replace(/[^0-9]/g, "")
                }
            }, 1)
        }
    }

    function d(p, m, k, j) {
        var o = c(p),
            f = o.datepicker("widget"),
            r = o.val();
        var u = j.settings,
            t = [],
            q = '<td style="text-align:center;font-size:0.8em;"><a class="ui-state-default #{ACTIVE_CLASS}#" style="text-align:center;">#{UK_VALUE}#</a></td>';
        if (u.yearUK) {
            t.push("UKUK-UK-UK")
        }
        if (u.monthUK) {
            t.push(m + "-UK-UK")
        }
        if (u.dayUK) {
            t.push([m, "-", k < 10 ? "0" : "", k, "-", "UK"].join(""))
        }
        var h = ['<table id="ui-datepicker-uk-tbl" style="width:100%;" cellspacing="30" class="ui-datepicker-calendar">'];
        h.push("<tr>");
        for (var l = 0, n = t.length; l < n; l++) {
            h.push(q.replace(/#\{([A-Z0-9_]+)\}#/gi, function() {
                switch (arguments[1]) {
                    case "ACTIVE_CLASS":
                        return (r == t[l] ? "ui-state-active" : "");
                    case "UK_VALUE":
                        return t[l]
                }
            }))
        }
        h.push("</tr>");
        h.push("</table>");
        var s = f.find("#ui-datepicker-uk-tbl");
        if (s.length > 0) {
            s.replaceWith(h.join(""))
        } else {
            f.find(".ui-datepicker-calendar").after(h.join(""))
        }
        f.find("#ui-datepicker-uk-tbl").on("click", "a", function(v) {
            o.val(v.currentTarget.innerHTML);
            o.datepicker("hide");
            return false
        });
        if (/UK/g.test(r)) {
            f.find(".ui-datepicker-calendar").eq(0).find(".ui-state-active").removeClass("ui-state-active")
        }
        var g = f.find("#ui-datepicker-clear");
		
        if (!g || g.length == 0) {
            var i = u.clearText || "Clear";
            f.find(".ui-datepicker-buttonpane").append('<button id="ui-datepicker-clear" class="ui-datepicker-current ui-state-default ui-priority-secondary ui-corner-all" type="button">' + i + "</button>");
            f.find("#ui-datepicker-clear").on("click", function() {
                o.val("");
                o.datepicker("hide");
                return false
            })
        }
		
    }


    function b(f, h, g) {
        setTimeout(function() {
            var i = g.input;
            d(i, f, h, g)
        }, 1)
    }
    c.fn.cubedatepicker = function(l) {
        var q = this,
            p = q.length,
            w, s, A, i;
        if (l) {
            w = l.isBeginElementId;
            s = l.isEndElementId;
            A = l.oppositeElement;
            i = l.datepickerOptions
        }
        if (i) {
            i = c.extend({}, e, i)
        } else {
            i = c.extend({}, e)
        }
        q.on("focusout", function(o) {
            var F = o.target,
                J = F.value.replace(/[^0-9]/g, ""),
                D = J.length,
                C = [];
            if (F.readOnly) {
                return
            }
            if (D > 3) {
                var H = parseInt(J.substring(0, 4), 10);
                C.push(H);
                if (D > 5) {
                    var G = parseInt(J.substring(4, 6), 10);
                    if (G > 0 && G < 13) {
                        if (G < 10) {
                            C.push("0" + G)
                        } else {
                            C.push(G)
                        }
                        if (C.length == 2 && D == 8) {
                            var I = parseInt(J.substring(6), 10);
                            if (I > 0 && I < 10) {
                                C.push("0" + I)
                            } else {
                                var E;
                                switch (G) {
                                    case 2:
                                        E = H % 4 == 0 ? 29 : 28;
                                        break;
                                    case 4:
                                    case 6:
                                    case 9:
                                    case 11:
                                        E = 30;
                                    default:
                                        E = 31;
                                        break
                                }
                                if (I < E + 1) {
                                    C.push(I)
                                }
                            }
                        }
                    }
                }
            }
            if (D > 0 && C.length < 3) {
                var B = c(F);
                switch (C.length) {
                    case 0:
                        if (B.datepicker("option", "yearUK")) {
                            C.push("UK")
                        }
                    case 1:
                        if (B.datepicker("option", "monthUK")) {
                            C.push("UK")
                        }
                    case 2:
                        if (B.datepicker("option", "dayUK")) {
                            C.push("UK")
                        }
                        break
                }
                if (C.length != 3) {
                    C = []
                }
            }
            F.value = C.join("-");
            c(J).trigger("change.datepicker")
        });
        q.on("keypress", function(B) {
            var C = B.target;
            var o;
            if (!B.which) {
                o = String.fromCharCode(B.keyCode)
            } else {
                if (B.which != 0 && B.charCode != 0) {
                    o = String.fromCharCode(B.which)
                }
            }
            if (o && (C.value.length > 7 || /[^0-9]/.test(o))) {
                if (document.addEventListener) {
                    B.preventDefault();
                    B.stopPropagation()
                } else {
                    if (document.attachEvent) {
                        B.returnValue = false
                    }
                }
            }
        });
        for (var z = 0, n = p; z < n; z++) {
            var t = q.eq(z),
                x = t.prop("id"),
                g = {};
            var f = t.attr("data-maxdate");
            if (f) {
                g.maxDate = f
            }
            f = t.attr("data-mindate");
            if (f) {
                g.minDate = f
            }
            f = t.attr("data-yyuk");
            if (f) {
                g.yearUK = true
            }
            f = t.attr("data-mmuk");
            if (f) {
                g.monthUK = true
            }
            f = t.attr("data-dduk");
            if (f) {
                g.dayUK = true
            }
            var y = w && w.call(this, x),
                v = s && s.call(this, x);
            g.isBeginElement = y;
            g.isEndElement = v;
            g.oppositeElement = A;
            if (!(y || v)) {
                if (!g.maxDate) {
                    g.maxDate = "+0d"
                }
            } else {
                if (y) {
                    var k = A ? A.call(t[0]) : [];
                    if (k.length == 1) {
                        var j = t.val(),
                            u = k.val();
                        if (j && j.length > 0 && j != "UKUK-UK-UK") {
                            j = j.replace(/UK/g, "01");
                            for (var r = 0, m = k.length; r < m; r++) {
                                var h = k.val();
                                k.datepicker("option", "minDate", j);
                                if (!j || (function() {
                                        var C = h.split("-"),
                                            B = j.split("-");
                                        for (var o = 0; o < 3; o++) {
                                            if (/UK/g.test(C[o]) || C[o] < B[o]) {
                                                return true
                                            }
                                        }
                                        return false
                                    }())) {
                                    k.val(h)
                                }
                            }
                        }
                        if (u && u.length > 0 && u != "UKUK-UK-UK") {
                            if (/^\d\d\d\d-UK-UK$/.test(u)) {
                                u = u.replace(/UK-UK$/, "12-31")
                            } else {
                                if (/^\d\d\d\d-\d\d-UK$/.test(u)) {
                                    u = u.replace(/^(\d\d\d\d)-(\d\d)-UK$/, function() {
                                        var C = arguments,
                                            B = parseInt(C[1], 10),
                                            D = parseInt(C[2], 10),
                                            o;
                                        switch (D) {
                                            case 1:
                                            case 3:
                                            case 5:
                                            case 7:
                                            case 8:
                                            case 10:
                                            case 12:
                                                o = 31;
                                                break;
                                            case 4:
                                            case 6:
                                            case 9:
                                            case 11:
                                                o = 30;
                                                break;
                                            case 2:
                                                o = (B % 4 == 0 ? 29 : 28);
                                                break
                                        }
                                        return [C[1], C[2], o].join("-")
                                    })
                                }
                            }
                        } else {
                            u = "+0d"
                        }
                        g.maxDate = u
                    }
                }
            }
            var h = t.val();
            t.datepicker(c.extend({}, i, g));
            if (!g.maxDate || (function() {
                    var C = h.split("-"),
                        B = g.maxDate.split("-");
                    for (var o = 0; o < 3; o++) {
                        if (/UK/g.test(C[o]) || C[o] > B[o]) {
                            return true
                        }
                    }
                    return false
                }())) {
                t.val(h)
            }
        }
        return this
    };
    c.fn.cubedbatchdatepicker = function(m) {
        var g = this,
            h, j, l, k;
        if (m) {
            h = m.batchItems;
            j = m.datepickerOptions;
            l = m.selectTriggerelement;
            k = m.showPosition
        }
        if (!h || !l || l.length == 0 || !k) {
            return this
        }
        if (j) {
            j = c.extend({}, e, j)
        } else {
            j = c.extend({}, e)
        }
        j.onClose = undefined;
        j.hideClear = true;
        var f = h.first(),
            n = {};
        var i = f.attr("data-maxdate");
        if (i) {
            n.maxDate = i
        } else {
            n.maxDate = "+0d"
        }
        i = f.attr("data-mindate");
        if (i) {
            n.minDate = i
        }
        i = f.attr("data-yyuk");
        if (i) {
            n.yearUK = true
        }
        i = f.attr("data-mmuk");
        if (i) {
            n.monthUK = true
        }
        i = f.attr("data-dduk");
        if (i) {
            n.dayUK = true
        }
        c(g).datepicker("dialog", undefined, function(q, p) {
            f.val(q);
            var o = c.Event("batchclose.datepicker");
            o.batchItems = h;
            l.trigger(o)
        }, c.extend({}, j, n), k);
        return this
    }
})(jQuery);
(function(f) {
    var j = "{][%&*empty$^%][}";
    var i = {};
    var d = {};
    var g = true;

    function h(w, o) {
        var u = i[w];
        var s = o.filter('[data-type="toggleradio"]');
        for (var n = 0, v = s.length; n < v; n++) {
            var q = s.eq(n),
                p = q.prop("name"),
                t = q.prop("value");
            if (t !== undefined || t !== null) {
                u[p] = t
            }
        }
    }

    function l(n) {
        n.on("change.radiotoggle", 'input[data-type="toggleradio"]', function(q) {
            var o = f(q.currentTarget),
                p = o.prop("name"),
                r = o.prop("value");
            k(n, p, r)
        })
    }

    function m(r, o) {
        var q = i[r];
        var n = o.filter(function() {
            return /checkbox/i.test(this.type)
        });
        for (var s = 0, t = n.length; s < t; s++) {
            var p = n.eq(s),
                v = p.prop("name"),
                u = p.prop("checked");
            if (u) {
                q[v] = u
            }
        }
    }

    function c(n) {
        n.on("click", 'input[type="checkbox"]', function(r) {
            var p = f(r.currentTarget),
                o = p.prop("name"),
                q = p.prop("checked");
            k(n, o, q)
        })
    }

    function a(u, n) {
        var r = i[u];
        var t = n.filter("select");
        for (var w = 0, p = t.length; w < p; w++) {
            var q = t.eq(w),
                o = q.prop("name"),
                v = q.prop("value");
            if (v !== undefined || v !== null) {
                r[o] = v
            }
        }
    }

    function b(n) {
        n.on("change", "select", function(q) {
            var p = f(q.currentTarget),
                o = p.prop("name"),
                r = p.prop("value");
            k(n, o, r)
        })
    }

    function e(n) {
        n.on("focus regist.detect", 'input[type="text"],textarea', function(r) {
            var s = i[n];
            var p = r.currentTarget,
                q = p.name;
            if (!s[q]) {
                var o = p.value;
                if (o === null || o === undefined || o === "") {
                    o = j
                }
                s[q] = o
            }
        });
        n.on("blur change.datepicker change.medicalcoding clear.medicalcoding", 'input[type="text"],textarea', function(r) {
            var s = i[n];
            var o = r.currentTarget,
                q = o.name,
                p = o.value;
            if (s[q] !== null && s[q] !== undefined) {
                if (p === null || p === undefined || p === "") {
                    p = j
                }
                k(n, q, p)
            }
        })
    }

    function k(u, t, s) {
        var r = i[u],
            n = d[u];
        var o = r[t],
            p = (o === s),
            v = f.inArray(t, n) > -1;
        if (!p && !v) {
            n.push(t)
        } else {
            if (p && v) {
                var w = [];
                for (var q = 0, x = n.length; q < x; q++) {
                    if (n[q] === t) {
                        continue
                    }
                    w.push(n[q])
                }
                n = w;
                d[u] = n
            }
        }
    }
    f.fn.detectchanged = function(q) {
        var n = this;
        var p = d[n];
        if (q === "init") {
            i[n] = {}, d[n] = [];
            var o = n.find("input,select,textarea");
            h(n, o);
            m(n, o);
            a(n, o);
            l(n);
            c(n);
            b(n);
            e(n);
            return this
        } else {
            if (q === "enabled") {
                g = true
            } else {
                if (q === "disabled") {
                    g = false
                }
            }
        }
        return (g && p && p.length > 0)
    }
})(jQuery);
(function(b) {
    var a, c;
    c = "medicalcoding";

    function d() {
        this.markerClassName = "hasMedicalCoding";
        this._pickerId = "medicalcoding";
        this._medicalcodingShowing = false;
        this._currElement = null;
        this._timeObj = {
            hh: "",
            mm: "",
            m: ""
        };
        this._selectedObj = {
            hh: null,
            mm: null,
            m: null
        };
        this.defaults = {
            maxHeight: 240,
            baseUrl: "",
            itemKey: "",
            codeType: undefined,
            codeVersion: undefined,
            texts: {
                MEDCOD_KEYWORD_SEARCH: "Search",
                MEDCOD_DIRECT_INPUT: "Submit",
                MEDCOD_PRODUCT: "Product"
            }
        };
        this.options = {};
        this._initEventHandler;
        this._cancelEventHandler;
        this._optionChangeEventHandler;
        this._searchEventHandler;
        this.pickerDiv = b('<div id="' + this._pickerId + '"></div>').addClass("layer-wrap").css({
            width: "600px",
            display: "none"
        });
        this.layerDiv = b("<div></div>").addClass("layer-pd").appendTo(this.pickerDiv);
        this.headerDiv = b("<div></div>").addClass("layer-top-area").appendTo(this.layerDiv);
        this.searchSelector = b('<select id="medcod-option" name="medcod-option"><option value=""></option></select>').appendTo(b("<div></div>").addClass("left mr5").appendTo(this.headerDiv)).change(b.proxy(this._optionChangeEventHandler, this));
        this.keywordDiv = b("<div></div>").addClass("left mr5").appendTo(this.headerDiv);
        this.btnSearch = b('<input type="button" value="Search" />').appendTo(b("<div></div>").addClass("left").appendTo(this.headerDiv)).button().click(b.proxy(this._searchEventHandler, this));
        this.titleDiv = b("<div></div>").addClass("right").appendTo(this.headerDiv);
        this.resultDiv = b("<div></div>").addClass("content").appendTo(b("<div></div>").addClass("nano").appendTo(this.layerDiv));
        this.resultTbl;
        this.buttonsDiv = b("<div></div>").addClass("layer-btn").appendTo(this.layerDiv);
        this.btnInit = b('<input type="button" value="Clear" />').appendTo(this.buttonsDiv).button().click(b.proxy(this._initEventHandler, this));
        this.btnCancel = b('<input type="button" value="Cancel" />').appendTo(this.buttonsDiv).button().click(b.proxy(this._cancelEventHandler, this));
        this.templates = {
            html: {
                optionBase: '<option value="#{VALUE}#">#{LABEL}#</option>',
                optionSelected: '<option value="#{VALUE}#" selected="selected">#{LABEL}#</option>',
                inputKeyword: '<input type="text" id="medcod-keyword" name="medcod-keyword" placeholder="#{PLACEHOLDER}#" style="width:150px;" />',
                selectFilter: '<select id="medcod-subj" name="medcod-subj" style="width:150px;"><option value="">#{LOADING}#</option></select>',
                resultTableWrap: '<table cellpadding="0" cellspacing="0" border="0" width="100%" class="layer-table1"><colgroup>#{COLS}#</colgroup><thead><tr>#{THEAD}#</tr></thead><tbody></tbody></table>',
                resultTableCol: '<col width="#{WIDTH_RATE}#%" />',
                resultTableHead: "<th>#{LABEL}#</th>",
                linkableResultCell: '<td><a href="#" onclick="return false;"><div style="word-break:break-all;">#{LABEL}#</div></a></td>',
                defaultResultCell: '<td style="word-break:break-all;">#{LABEL}#</td>'
            },
            replacement: function(g, f) {
                var h = /#{([A-Z0-9_]+)}#/g;
                return g.replace(h, function() {
                    var i = arguments[1];
                    if (f[i]) {
                        return f[i]
                    }
                    return ""
                })
            }
        };
        var e = this;
        this.keywordDiv.on("keyup", 'input[type="text"]', function(f) {
            if (f.keyCode == 13 && e.btnSearch.is(":visible")) {
                e.btnSearch.trigger("click")
            }
        })
    }
    d.prototype.getTableColumnModel = function(i, g) {
        var e = this;
        var h = {
            FIRSTDIS: [{
                title: (e.options.texts.MEDCOD_PRODUCT || "상품명"),
                width: 30,
                format: "#{EDI_NAME}#",
                link: "EDI_NAME"
            }, {
                title: (e.options.texts.MEDCOD_INGREDIENT || "성분명"),
                width: 40,
                format: "#{CONST_NAME_ENG}#"
            }, {
                title: (e.options.texts.MEDCOD_DEALER || "판매회사"),
                width: 30,
                format: "#{DEALER}#"
            }],
            "FIRSTDIS-KOR_ENG": [{
                title: (e.options.texts.MEDCOD_PRODUCT || "상품명"),
                width: 25,
                format: "#{EDI_NAME}#",
                link: "EDI_NAME"
            }, {
                title: (e.options.texts.MEDCOD_PRODUCT_EN || "상품명(영문)"),
                width: 25,
                format: "#{EDI_NAME_ENG}#"
            }, {
                title: (e.options.texts.MEDCOD_INGREDIENT || "성분명"),
                width: 25,
                format: "#{CONST_NAME_ENG}#"
            }, {
                title: (e.options.texts.MEDCOD_DEALER || "판매회사"),
                width: 25,
                format: "#{DEALER}#"
            }],
            "FIRSTDIS-ENG_KOR": [{
                title: (e.options.texts.MEDCOD_PRODUCT_EN || "상품명(영문)"),
                width: 25,
                format: "#{EDI_NAME_ENG}#",
                link: "EDI_NAME_ENG"
            }, {
                title: (e.options.texts.MEDCOD_PRODUCT || "상품명"),
                width: 25,
                format: "#{EDI_NAME}#"
            }, {
                title: (e.options.texts.MEDCOD_INGREDIENT || "성분명"),
                width: 25,
                format: "#{CONST_NAME_ENG}#"
            }, {
                title: (e.options.texts.MEDCOD_DEALER || "판매회사"),
                width: 25,
                format: "#{DEALER}#"
            }],
            "FIRSTDIS-KOR(ENG)": [{
                title: (e.options.texts.MEDCOD_PRODUCT_KO_EN || "상품명"),
                width: 30,
                format: "#{EDI_NAME}# (#{EDI_NAME_ENG}#)",
                link: "EDI_NAME"
            }, {
                title: (e.options.texts.MEDCOD_INGREDIENT || "성분명"),
                width: 40,
                format: "#{CONST_NAME_ENG}#"
            }, {
                title: (e.options.texts.MEDCOD_DEALER || "판매회사"),
                width: 25,
                format: "#{DEALER}#"
            }],
            ATC_INDEX: [{
                title: (e.options.texts.MEDCOD_ATC_L5 || "5th level"),
                width: 20,
                format: "#{NAME_5}#",
                link: "NAME_5"
            }, {
                title: (e.options.texts.MEDCOD_ATC_L4 || "4th level"),
                width: 20,
                format: "#{NAME_4}#",
                link: "NAME_4"
            }, {
                title: (e.options.texts.MEDCOD_ATC_L3 || "3rd level"),
                width: 20,
                format: "#{NAME_3}#",
                link: "NAME_3"
            }, {
                title: (e.options.texts.MEDCOD_ATC_L2 || "2nd level"),
                width: 20,
                format: "#{NAME_2}#",
                link: "NAME_2"
            }, {
                title: (e.options.texts.MEDCOD_ATC_L1 || "1st level"),
                width: 20,
                format: "#{NAME_1}#",
                link: "NAME_1"
            }],
            MEDDRA: [{
                title: (e.options.texts.MEDCOD_MEDDRA_LLT || "LLT"),
                width: 30,
                format: "#{LLT_NAME}#",
                link: "LLT_NAME"
            }, {
                title: (e.options.texts.MEDCOD_MEDDRA_PT || "PT"),
                width: 30,
                format: "#{PT_NAME}#"
            }, {
                title: (e.options.texts.MEDCOD_MEDDRA_SOC || "SOC (Primary)"),
                width: 40,
                format: "#{SOC_NAME}#"
            }],
            WHOART: [{
                title: (e.options.texts.MEDCOD_WHOART_TERM || "용어 (한글)"),
                width: 50,
                format: "#{INCL_TERM}#",
                link: "INCL_TERM"
            }, {
                title: (e.options.texts.MEDCOD_WHOART_TERM_ENG || "용어 (WHOART 영문)"),
                width: 50,
                format: "#{TERM_ENG}#"
            }],
            KCD: [{
                title: (e.options.texts.MEDCOD_KCD_TERM || "용어 (한글)"),
                width: 50,
                format: "#{TERM_KO}#",
                link: "TERM_KO"
            }, {
                title: (e.options.texts.MEDCOD_KCD_TERM_ENG || "용어 (영문)"),
                width: 50,
                format: "#{TERM_EN}#"
            }],
            MFDS_INGR: [{
                title: (e.options.texts.MEDCOD_MFDS_INGR_TERM || "성분명 (한글)"),
                width: 50,
                format: "#{TERM_KO}#",
                link: "TERM_KO"
            }, {
                title: (e.options.texts.MEDCOD_MFDS_INGR_TERM_ENG || "성분명 (영문)"),
                width: 50,
                format: "#{TERM_EN}#"
            }],
            MFDS_DM: [{
                title: (e.options.texts.MEDCOD_MFDS_DM_TERM || "제품 (한글)"),
                width: 50,
                format: "#{TERM_KO}#",
                link: "TERM_KO"
            }, {
                title: (e.options.texts.MEDCOD_MFDS_DM_TERM_ENG || "제품 (영문)"),
                width: 50,
                format: "#{TERM_EN}#"
            }],
            CTCAE: [{
                title: (e.options.texts.MEDCOD_CTCAE_AE || "Adverse Event"),
                width: 50,
                format: "",
                link: ""
            }, {
                title: (e.options.texts.MEDCOD_CTCAE_SOC || "SOC"),
                width: 50,
                format: ""
            }],
            INSERTED: [{
                title: (e.options.texts.MEDCOD_DRUG || "약물"),
                width: 50,
                format: "#{VALUE}#",
                link: "VALUE"
            }, {
                title: (e.options.texts.MEDCOD_SUBJECT || "피험자"),
                width: 50,
                format: "#{SUBJ_ID}#"
            }],
            PREPARED: [{
                title: (e.options.texts.MEDCOD_DRUG || "약물"),
                width: 100,
                format: "#{VALUE}#",
                link: "VALUE"
            }]
        };
        var f = "";
        if (i == "FIRSTDIS" && /^(DEFAULT|KOR)$/.test(g) === false) {
            f = i.concat("-", g)
        } else {
            if (/^INSERTED/i.test(i)) {
                f = "INSERTED"
            } else {
                f = i
            }
        }
        return h[f]
    };
    b.extend(d.prototype, {
        _attachMedicalCoding: function(g, f) {
            var e = this;
            g.data("medcod-options", f);
            g.addClass(this.markerClassName).click(function(l) {
                if (e._medicalcodingShowing && g.data(c) == e) {
                    return false
                }
                if (g.data("deleted") == true) {
                    return false
                }
                g.data(c, e);
                e.options = b.extend([], e.defaults, g.data("medcod-options"));
                e.titleDiv.html("Loading...");
                e.resultDiv.empty().parent().css({
                    height: ""
                });
                e.resultTbl = null;
                e.searchSelector.empty();
                if (e.options.codeType && e.options.codeVersion) {
                    var j = undefined,
                        i = undefined;
                    if (b.isFunction(e.options.codeType)) {
                        j = e.options.codeType.apply(e, [g])
                    }
                    if (b.isFunction(e.options.codeVersion)) {
                        i = e.options.codeVersion.apply(e, [g])
                    }
                    if (j === undefined || (!/MFDS_(INGR|DM)/.test(j) && i === undefined)) {
                        return false
                    }
                    if (j == "ATC") {
                        j = "ATC_INDEX"
                    }
                    var h = {
                        id: j,
                        title: "",
                        version: i,
                        inputType: "TEXT"
                    };
                    switch (j) {
                        case "MEDDRA":
                            h.title = "MedDRA";
                            break;
                        case "WHOART":
                            h.title = "WHOART";
                            break;
                        case "KCD":
                            h.title = "KCD";
                            break;
                        case "MFDS_INGR":
                            h.title = "MFDS Ingredient";
                            break;
                        case "MFDS_DM":
                            h.title = "MFDS Product";
                            break;
                        case "ATC_INDEX":
                            h.title = "ATC Index";
                            break
                    }
                    if (i) {
                        h.title += " ver." + i
                    }
                    e.searchSelector.css("display", "none").find("option").remove();
                    e.searchSelector.append(b(e.templates.replacement(e.templates.html.optionSelected, {
                        VALUE: h.id,
                        LABEL: h.id
                    })).data("option", h));
                    e._updateDialog(e, h)
                } else {
                    b.ajax({
                        url: e.options.baseUrl + ".json",
                        data: {
                            itemKey: e.options.itemKey
                        },
                        dataType: "json",
                        success: function(r) {
                            if (r.select) {
                                var o = [];
                                for (var q = 0, n = r.select.length; q < n; q++) {
                                    var p = r.select[q];
                                    o.push(b(e.templates.replacement(e.templates.html.optionBase, {
                                        VALUE: p.value,
                                        LABEL: p.alias
                                    })).data("option", p));
                                    if (q == 0) {
                                        e._updateDialog(e, p)
                                    }
                                }
                                e.searchSelector.append(o).parent().css({
                                    width: e.searchSelector.outerWidth() + "px"
                                })
                            }
                        }
                    })
                }
                e._medicalcodingShowing = true;
                e._currElement = g;
                var k = g.offsetParent();
                if (k.parents("#popover").length > 0) {
                    k = k.closest("#popover").offsetParent()
                } else {
                    if (k.is(".item-row-wrap")) {
                        k = k.offsetParent()
                    }
                }
                k.append(e.pickerDiv);
                e.pickerDiv.css({
                    top: "0",
                    left: "0"
                }).show();
                e.resultDiv.parent().nanoScroller();
                e.pickerDiv.position({
                    at: "left bottom",
                    my: "left top",
                    of: g,
                    using: function(n) {
                        if (n.left < 10) {
                            n.left = 10
                        }
                        e.pickerDiv.css(n)
                    }
                });
                var m = e.keywordDiv.find("#medcod-keyword");
                if (m && m.length > 0) {
                    m[0].focus()
                }
                return false
            })
        },
        _updateDialog: function(k, h) {
            var o = this;
            if (h.title) {
                k.titleDiv.html(h.title)
            } else {
                k.titleDiv.html("")
            }
            if (h.inputType == "TEXT") {
                k.keywordDiv.css("display", "block")[0].innerHTML = this.templates.replacement(this.templates.html.inputKeyword, {
                    PLACEHOLDER: h.helpText
                });
                k.btnSearch.val(h.id == "USER_INPUT" ? (o.options.texts.MEDCOD_DIRECT_INPUT || "입력") : (o.options.texts.MEDCOD_KEYWORD_SEARCH || "검색")).show()
            } else {
                if (h.inputType == "SELECT") {
                    k.keywordDiv.css("display", "block")[0].innerHTML = this.templates.replacement(this.templates.html.selectFilter, {
                        LOADING: (o.options.texts ? o.options.texts.LOADING : "Loading...")
                    });
                    k.btnSearch.val((o.options.texts.MEDCOD_KEYWORD_SEARCH || "검색")).hide();
                    b.post(k.options.baseUrl + "/subject.json", {
                        itemKey: o.options.itemKey,
                        select: h.value
                    }, function(s) {
                        var q = [];
                        q.push(o.templates.replacement(o.templates.html.optionBase, {
                            LABEL: (o.options.texts ? o.options.texts.MEDCOD_SELECT_SUBJECT : "피험자를 선택하세요.")
                        }));
                        for (var r = 0, p = s.subjectList.length; r < p; r++) {
                            q.push(o.templates.replacement(o.templates.html.optionBase, {
                                VALUE: s.subjectList[r]["subjectId"],
                                LABEL: s.subjectList[r]["subjectId"]
                            }))
                        }
                        b("#medcod-subj").empty().append(q.join("")).on("change", b.proxy(k._sbjChangeEventHandler, k))
                    }, "json")
                } else {
                    k.keywordDiv.empty();
                    k.btnSearch.hide();
                    b.post(k.options.baseUrl + "/search.json", {
                        itemKey: o.options.itemKey,
                        select: h.value
                    }, function(i) {
                        o._updateResult(k, [{
                            name: "CM_NAME",
                            link: true
                        }], i.searchResult, undefined)
                    }, "json")
                }
            }
            var f = k.getTableColumnModel(h.id, h.designId);
            if (f) {
                var g = [],
                    m = [];
                for (var j = 0, l = f.length; j < l; j++) {
                    var e = f[j];
                    g.push(o.templates.replacement(o.templates.html.resultTableCol, {
                        WIDTH_RATE: e.width
                    }));
                    m.push(o.templates.replacement(o.templates.html.resultTableHead, {
                        LABEL: e.title
                    }))
                }
                k.resultDiv[0].innerHTML = o.templates.replacement(o.templates.html.resultTableWrap, {
                    COLS: g.join(""),
                    THEAD: m.join("")
                });
                k.resultTbl = k.resultDiv.children("table");
                var n = Math.min(k.options.maxHeight, k.resultTbl.outerHeight());
                k.resultDiv.parent().css({
                    height: n + "px"
                });
                if (/MSIE\s*7/gi.test(navigator.userAgent)) {
                    k.resultDiv.css({
                        height: n + "px"
                    })
                }
            } else {
                k.resultDiv.parent().css({
                    height: ""
                });
                if (/MSIE\s*7/gi.test(navigator.userAgent)) {
                    k.resultDiv.css({
                        height: ""
                    })
                }
            }
            k.pickerDiv.position({
                at: "left bottom",
                my: "left top",
                of: k._currElement,
                using: function(i) {
                    if (i.left < 10) {
                        i.left = 10
                    }
                    k.pickerDiv.css(i)
                }
            })
        },
        _optionChangeEventHandler: function(e) {
            this.resultDiv.empty();
            this._updateDialog(this, b(e.target).children(":selected").data("option"))
        },
        _updateResult: function(k, l, g, f) {
            var e = this;
            k.resultTbl.find("tr:gt(0)").remove();
            if (g && g.length > 0) {
                var j = [],
                    i = (f ? new RegExp(f, "gi") : undefined);
                b.each(g, function(q, v) {
                    var r = b("<tr></tr>"),
                        o = false;
                    j.push(r);
                    for (var s = 0, t = l.length; s < t; s++) {
                        var n = l[s],
                            u = e.templates.replacement(n.format, v);
                        if (i && u) {
                            u = u.replace(i, function() {
                                return ['<span class="red">', arguments[0], "</span>"].join("")
                            })
                        }
                        if (o === false && n.link && u != "") {
                            o = true;
                            var m = n.link,
                                p = e.templates.replacement(n.format, v);
                            b(e.templates.replacement(e.templates.html.linkableResultCell, {
                                LABEL: u
                            })).appendTo(r).on("click", "a", function() {
                                k._setCodingValue(k, k._currElement, p, b.extend({
                                    SEL_CODE: m
                                }, v));
                                return false
                            })
                        } else {
                            b(e.templates.replacement(e.templates.html.defaultResultCell, {
                                LABEL: u || "&nbsp;"
                            })).appendTo(r)
                        }
                    }
                });
                k.resultTbl.find("tbody").append(j)
            } else {
                k.resultTbl.find("tbody").append('<tr><td colspan="'.concat(l.length, '">No data</td></tr>'))
            }
            var h = Math.min(k.options.maxHeight, k.resultTbl.outerHeight());
            if (/MSIE\s*7/gi.test(navigator.userAgent)) {
                k.resultDiv.css({
                    height: h + "px"
                })
            }
            b(document.body).css("overflow", "hidden");
            k.resultDiv.parent().css({
                height: h + "px"
            }).nanoScroller();
            k.pickerDiv.position({
                at: "left bottom",
                my: "left top",
                of: k._currElement,
                using: function(m) {
                    if (m.left < 10) {
                        m.left = 10
                    }
                    k.pickerDiv.css(m)
                }
            });
            b(document.body).css("overflow", "")
        },
        _searchEventHandler: function(g) {
            var h, f, e;
            h = this;
            f = this.searchSelector.children(":selected").data("option");
            e = this.keywordDiv.find("#medcod-keyword").val();
            if (f.id == "USER_INPUT") {
                h._setCodingValue(h, h._currElement, e, {
                    ITEM_KEY: this.options.itemKey,
                    SOURCE_ID: f.id,
                    SEARCH_TEXT: e
                })
            } else {
                if ((/[^a-zA-Z]/.test(e) == false && e.length < 3) || e.length < 2) {
                    alert(h.options.texts.MEDCOD_KEYWORD_SEARCH_WARNING || "한글은 2자이상, 영문은 3자이상, 숫자는 2자리 이상 입력하세요.");
                    return false
                }
                var i = h.getTableColumnModel(f.id, f.designId),
                    j = {};
                if (h.options.itemKey) {
                    j = {
                        itemKey: h.options.itemKey,
                        select: f.value,
                        searchWord: e
                    }
                } else {
                    j = {
                        codeType: f.id,
                        searchWord: e,
                        version: f.version
                    }
                }
                b.ajax({
                    url: h.options.baseUrl + "/search.json",
                    method: "POST",
                    data: j,
                    dataType: "json",
                    success: function(k) {
                        h._updateResult(h, i, k.searchResult, e)
                    }
                })
            }
        },
        _sbjChangeEventHandler: function(g) {
            var h = this,
                f = this.searchSelector.children(":selected").data("option"),
                e = b(g.target).val();
            b.post(this.options.baseUrl + "/search.json", {
                itemKey: this.options.itemKey,
                select: f.value,
                searchWord: e
            }, function(i) {
                var j = h.getTableColumnModel(f.id);
                h._updateResult(h, j, i.searchResult)
            }, "json")
        },
        _initEventHandler: function(f) {
            var e = b(this._currElement);
            e.val("");
            e.trigger("clear.medicalcoding")
        },
        _cancelEventHandler: function(e) {
            this._closeHandler(e)
        },
        _closeHandler: function(e) {
            if (a._medicalcodingShowing == false) {
                return false
            }
            a.pickerDiv.css({
                top: "0",
                left: "0"
            }).hide();
            a._medicalcodingShowing = false;
            a._currElement.removeData(c);
            a._currElement = null
        },
        _setCodingValue: function(l, h, n, e) {
            var o = b(h);
            o.val(n);
            var g = o.closest(".question-body").find("[data-medcod]").filter(function() {
                    return /^textarea$/i.test(this.tagName) || (/^input$/i.test(this.tagName) && /^(text|hidden)$/i.test(this.type))
                }),
                f = g.length;
            if (f > 0) {
                for (var j = 0; j < f; j++) {
                    var m = g.eq(j),
                        p = m.attr("data-medcod");
                    if (e[p]) {
                        m.val(e[p])
                    } else {
                        m.val("")
                    }
                }
            }
            l._closeHandler();
            if (e && l.options.itemKey) {
                var k = /^item_\d+_\d+_(\d+)_(\d+)$/.exec(o.attr("name"));
                if (k) {
                    if (k[1]) {
                        e.ROW_NO_PARENT = k[1]
                    }
                    if (k[2]) {
                        e.ROW_NO = k[2]
                    }
                }
                b.ajax({
                    type: "POST",
                    url: this.options.baseUrl + "/upd-selection.json",
                    data: e,
                    hideLoading: true
                })
            }
            o.trigger("change.medicalcoding", [e])
        },
        _checkExternalClick: function(f) {
            var e = b(f.target);
            if (a._medicalcodingShowing && e.attr("id") != a._pickerId && e.parents("#" + a._pickerId).length == 0 && e.data(c) != a) {
                a._closeHandler(f)
            }
        }
    });
    b.fn.medicalcoding = function(f) {
        if (!this.length) {
            return this
        }
        if (!a.initialized) {
            b(document).mousedown(a._checkExternalClick).find(document.body).append(a.pickerDiv);
            b(window).resize(a._closeHandler);
            a.initialized = true
        }
        var e = Array.prototype.slice.call(arguments, 1);
        if (typeof f == "string") {
            a[f].apply(a, this.concat(e))
        } else {
            a._attachMedicalCoding(this, f)
        }
        return this
    };
    a = new d();
    a.initialized = false
}(jQuery));
(function(a) {
    a.fn.noticepopup = function(d, b) {
        var c;
        if (b) {
            c = a.extend({}, a.fn.noticepopup.defaults, b)
        } else {
            c = a.fn.noticepopup.defaults
        }
        return this.each(function() {
            var h, k, j, f, i, m, l, g, e;
            f = a(this);
            l = {
                width: a(window).width(),
                height: a(window).height()
            };
            m = f.offset();
            h = a("<div></div>").addClass(c.outerClassName).css({
                visibility: "hidden",
                left: "0",
                top: "0",
                position: "absolute"
            });
            i = a("<div></div>").addClass(c.innerClassName).append(a("<span></span>").html(d)).appendTo(h);
            a(document.body).append(h);
            e = h.find("span").width() + (i.outerWidth() - i.width());
            h.css("width", (e < c.width ? e : c.width));
            g = {
                top: (m.top < l.height / 2) ? m.top + f.outerHeight() : m.top - h.outerHeight(),
                left: (m.left < l.width / 2) ? m.left : m.left + f.outerWidth() - h.outerWidth(),
                direction: (m.top < l.height / 2) ? "up" : "down"
            };
            h.css({
                top: g.top,
                left: g.left,
                visibility: "visible",
                display: "none"
            });
            j = f.data("notice");
            if (j) {
                j.stop(true, true);
                j.remove()
            }
            f.data("notice", h);
            h.show("slide", {
                direction: g.direction
            }, 400).delay(c.delayTime).fadeOut(500, function() {
                a.removeData(f, "notice");
                h.remove()
            })
        })
    };
    a.fn.errorpopup = function(c, b) {
        if (b) {
            b = a.extend({}, a.fn.noticepopup.defaults, {
                outerClassName: "layer-wrap2",
                innerClassName: "layer-alarm2"
            }, b);
            this.noticepopup(c, b)
        } else {
            this.noticepopup(c, {
                outerClassName: "layer-wrap2",
                innerClassName: "layer-alarm2"
            })
        }
    };
    a.fn.noticepopup.defaults = {
        outerClassName: "layer-wrap1",
        innerClassName: "layer-alarm1",
        width: 220,
        delayTime: 2000
    }
})(jQuery);
(function(g) {
    var e = {
        tableWrapClassName: "",
        tableClassName: "",
        resourceRootPath: "/resources/image/",
        selectable: false,
        countable: false,
        countCellWidthRate: "4%",
        editable: true,
        editLabel: "Edit",
        deletedRowClassName: "deleted",
        rowNum: 10,
        rowNumOptions: [10, 20, 30, 50, 100],
        pagingNum: 10,
        pagingWrapClassName: "paging-wrap",
        pagingFirstLabel: "First",
        pagingPreviousLabel: "Prev",
        pagingNextLabel: "Next",
        pagingLastLabel: "Last",
        columns: [],
        paginatedListProperty: undefined,
        initPageIndex: 1,
        initContent: undefined,
        emptyContentLabel: "Data does not exist.",
        loaderURL: "",
        exportURL: "",
        extraParam: {},
        linkDecisionFunc: undefined,
        rowCSSDecisionFunc: undefined,
        filterNotifySelector: undefined,
        filterAppliedHTML: undefined,
        filterAllSelectLabel: "Select all",
        colSpan: 1
    };
    var m = ["[", String.fromCharCode(15), "NULL", String.fromCharCode(15), "]"].join("");
    var o = {
        wrap: "".concat('<div class="#{LIST_WRAP_CLASS}#">', '<table border="0" width="100%" cellpadding="0" cellspacing="0" class="#{LIST_CLASS}#">', "<colgroup>#{COL_GROUPS}#</colgroup>", "<thead><tr>#{LIST_HEADER}#</tr></thead>", "<tbody>#{LIST_BODY}#</tbody>", "<tfoot>#{LIST_OPTION}#</tfoot>", "</table>", "</div>"),
        colWidthCell: '<col width="#{WIDTH_RATE}#"/>',
        headerCell: "<th>#{LABEL}##{FILTER}#</th>",
        filterHTML: ' <a href="#" onclick="return false;" data-filter="#{COLUMN_ID}#"><img src="#{IMAGE_PATH}#" alt="" style="vertical-align:-30%;"/></a>',
        dataRowHTML: '<tr style="cursor:pointer;" data-index="#{INDEX}#">#{DATA}#</tr>',
        dataCell: '<td style="text-align:#{TEXT_ALIGN}#;">#{DATA}#</td>',
        styledDataCell: '<td class="#{STYLE_CLASS}#" style="text-align:#{TEXT_ALIGN}#;">#{DATA}#</td>',
        baseDataHTML: "<div>#{DATA}#</div>",
        linkableDataCell: '<a href="#" onclick="return false;" data-columnid="#{COLUMN_ID}#">#{DATA}#</a>',
        editCell: '<td><a href="#" onclick="return false;" data-action="edit"><div>#{EDIT_LABEL}#</div></a></td>',
        selectableHeaderHTML: '<input type="checkbox" name="list-select-all" />',
        selectableDataHTML: '<input type="checkbox" name="list-select-row" />',
        emptyData: '<tr><td colspan="#{COL_SPAN}#"><div>#{EMPTY_LABEL}#</div></td></tr>',
        pagingWrap: '<div class="#{PAGING_WRAP_CLASS}#"> #{BODY}#</div>',
        pagingHTML: '<a href="#" onclick="return false;" data-index="#{INDEX}#">#{LABEL}#</a>',
        currentPagingHTML: '<a href="#" onclick="return false;" data-index="#{INDEX}#" class="page-on">#{LABEL}#</a>',
        footerHTML: '<tr><td colspan="#{COL_SPAN}#" class="set-row-num"><div>View rows: <select name="list-view-rows">#{OPTIONS}#</select></div></td></tr>',
        baseOption: '<option value="#{VALUE}#">#{LABEL}#</option>',
        selectedOption: '<option value="#{VALUE}#" selected="selected">#{LABEL}#</option>',
        baseCheckbox: '<div><label><input type="checkbox" value="#{VALUE}#" /> #{LABEL}#</label></div>',
        checkedCheckbox: '<div><label><input type="checkbox" value="#{VALUE}#" checked="checked" /> #{LABEL}#</label></div>',
        filterLike: '<table cellpadding="0" cellspacing="0" border="0" class="layer-table1"><tr><td><div><input type="text" style="width:170px;" value="#{BEFORE}#" /></div></td></tr></table>',
        filterHeader: '<div><input type="text" style="width:100%;" /></div>',
        filterSelect: "".concat('<table cellpadding="0" cellspacing="0" border="0" class="layer-table1" style="min-width:200px;">', '<tbody><tr><td>#{ALL_CHECKBOX}#</td></tr><tr><td><div style="overflow:auto;max-height:200px;">#{OPTION_CHECKBOXES}#</div></td></tr></tbody>', "</table>")
    };
    var p = {
        getKey: function(r) {
            return "pl-" + r.replace(/^\//, "").replace(/\//g, ".")
        },
        storePageIndex: function(s, r) {
            document.cookie = p.getKey(s) + "=" + r + ";path=/"
        },
        restorePageIndex: function(r) {
            var s = document.cookie,
                v = p.getKey(r);
            var u = s.indexOf(" " + v + "=");
            if (u == -1) {
                u = s.indexOf(v + "=")
            }
            if (u == -1) {
                s = null
            } else {
                u = s.indexOf("=", u) + 1;
                var t = s.indexOf(";", u);
                if (t == -1) {
                    t = s.length
                }
                s = s.substring(u, t)
            }
            return s
        }
    };

    function d(s, r) {
        return s.replace(/#{([A-Z_]+)}#/gi, function() {
            var u = arguments[1];
            if (r[u] !== undefined) {
                var t = "";
                if (g.isArray(r[u])) {
                    t = r[u].join("")
                } else {
                    t = r[u] + ""
                }
                return t.replace(m, "")
            }
            return ""
        })
    }
    g.fn.paginatedList = function(A) {
        var r = g(this);
        if (!A || typeof A == "object") {
            var s = g.extend({}, e, A),
                t = h(s),
                v;
            if (s.initContent) {
                var z = s.initContent.rowData,
                    y = s.initContent.totalCount;
                g.extend(t, i(s, z, y, s.initPageIndex), c(s));
                v = l(s, s.initPageIndex, y)
            } else {
                v = []
            }
            g.extend(t, {
                LIST_WRAP_CLASS: s.tableWrapClassName,
                LIST_CLASS: s.tableClassName
            });
            r.html(d(o.wrap, t) + d(o.pagingWrap, {
                PAGING_WRAP_CLASS: s.pagingWrapClassName,
                BODY: v.join("")
            }));
            var u = ".".concat(s.pagingWrapClassName);
            var x = {
                tableBody: r.find("tbody"),
                pagingWrap: r.find(u),
                currentData: undefined,
                currentPage: 0,
                options: s
            };
            r.data("instance", x);
            if (s.initContent) {
                x.currentData = s.initContent.rowData;
                x.currentPage = s.initPageIndex
            } else {
                a(s, s.initPageIndex, x)
            }
            r.on("click", "thead [data-filter]", function(D) {
                var G = g(D.currentTarget),
                    F = G.attr("data-filter"),
                    E = s.paginatedListProperty,
                    C;
                for (var H = 0, B = s.columns.length; H < B; H++) {
                    if (s.columns[H].id == F) {
                        C = s.columns[H];
                        break
                    }
                }
                if (!C) {
                    return
                }
                b(G.closest("th"), E, C, s.filterAllSelectLabel, function(I) {
                    a(s, 1, x);
                    if (I != C.filtered) {
                        var J = G.find("img"),
                            K = J.prop("src");
                        if (I) {
                            J.prop("src", K.replace(/off\.png$/, "on.png"))
                        } else {
                            J.prop("src", K.replace(/on\.png$/, "off.png"))
                        }
                    }
                    C.filtered = I
                })
            });
            r.on("click", u + " a", function() {
                var C = g(this);
                if (C.is(".page-on")) {
                    return false
                }
                var B = parseInt(C.attr("data-index"), 10);
                a(s, B, x)
            });
            var w = ".".concat(A.tableClassName, " tbody a,.", A.tableClassName, " tbody tr[data-index]");
            r.on("click", w, function(E) {
                var F = g(E.target),
                    B;
                if (F.is("tr")) {
                    B = F;
                    F = B.find("td:eq(0)")
                } else {
                    B = F.closest("tr")
                }
                var G = parseInt(B.attr("data-index"), 10),
                    C = "",
                    D = {};
                if (F.is('[data-action="edit"]')) {
                    C = "rowEdit.paginatedList"
                } else {
                    C = "cellClick.paginatedList";
                    D.columnId = F.attr("data-columnid")
                }
                D.model = x.currentData[G];
                D.clickedCell = F.closest("td");
                r.trigger(C, D);
                return false
            });
            r.on("change", 'tfoot select[name="list-view-rows"]', function(C) {
                var E = s.rowNum,
                    F = parseInt(C.currentTarget.value, 10);
                if (E == F || isNaN(E) || isNaN(F)) {
                    return
                }
                var D = x.currentPage,
                    B = Math.ceil((E * (D - 1) + 1) / F);
                if (isNaN(B)) {
                    return
                }
                if (s.paginatedListProperty) {
                    g.ajax({
                        type: "POST",
                        url: "/paginated/row-count.json",
                        data: {
                            property: s.paginatedListProperty,
                            count: F
                        },
                        dataType: "json",
                        hideLoading: true,
                        success: function() {
                            if (x.currentData === undefined || x.currentData.length == 0) {
                                return
                            }
                            s.rowNum = F;
                            x.currentPage = B;
                            a(x.options, x.currentPage, x)
                        }
                    })
                } else {
                    s.rowNum = F;
                    x.currentPage = B;
                    a(x.options, x.currentPage, x)
                }
            })
        } else {
            if (A == "refresh") {
                var x = r.data("instance");
                a(x.options, x.currentPage, x)
            } else {
                if (A == "reload") {
                    var x = r.data("instance");
                    a(x.options, 1, x)
                }
            }
        }
    };

    function h(z) {
        var w = [],
            s = [];
        if (z.selectable) {
            w.push(d(o.colWidthCell, {
                WIDTH_RATE: "4%"
            }));
            s.push(d(o.headerCell, {
                LABEL: o.selectableHeaderHTML
            }))
        }
        if (z.countable) {
            w.push(d(o.colWidthCell, {
                WIDTH_RATE: z.countCellWidthRate
            }));
            s.push(d(o.headerCell, {
                LABEL: "No."
            }))
        }
        var x = false;
        for (var v = 0, y = z.columns.length; v < y; v++) {
            var t = z.columns[v];
            if (t.visible === false) {
                continue
            }
            var u = "";
            if (t.filter && !(/NONE/i.test(t.filter))) {
                u = d(o.filterHTML, {
                    COLUMN_ID: t.id,
                    IMAGE_PATH: z.resourceRootPath.concat("filter-", (t.filtered ? "on" : "off"), ".png")
                });
                x = x || t.filtered
            }
            var r;
            if (t.width !== undefined && t.width > 0) {
                r = t.width + "%"
            } else {
                r = ""
            }
            w.push(d(o.colWidthCell, {
                WIDTH_RATE: r
            }));
            s.push(d(o.headerCell, {
                LABEL: t.label,
                FILTER: u
            }))
        }
        if (z.editable) {
            w.push(d(o.colWidthCell, {
                WIDTH_RATE: ""
            }));
            s.push(d(o.headerCell, {
                LABEL: "&nbsp;"
            }))
        }
        if (x && z.filterNotifySelector && z.filterAppliedHTML) {
            g(z.filterNotifySelector).append(z.filterAppliedHTML)
        }
        z.colSpan = w.length;
        return {
            COL_GROUPS: w,
            LIST_HEADER: s
        }
    }

    function i(A, y, u, r) {
        if (u == 0 || !y) {
            return {
                LIST_BODY: d(o.emptyData, {
                    COL_SPAN: A.colSpan,
                    EMPTY_LABEL: A.emptyContentLabel
                })
            }
        }
        var x = [],
            w = u - (A.rowNum * (r - 1));
        for (var s = 0, z = y.length; s < z; s++) {
            var t = y[s],
                v = q(A, t, w--);
            x.push(d(o.dataRowHTML, {
                INDEX: s,
                DATA: v.join("")
            }))
        }
        return {
            LIST_BODY: x.join("")
        }
    }

    function q(F, A, s) {
        var D = [],
            w = A.deleted,
            v = "center",
            B;
        if (w) {
            B = F.deletedRowClassName
        } else {
            if (F.rowCSSDecisionFunc) {
                B = F.rowCSSDecisionFunc.call(this, A)
            }
        }
        var C = B ? o.styledDataCell : o.dataCell;
        if (F.selectable) {
            D.push(o.selectableDataHTML)
        }
        if (F.countable) {
            D.push(d(C, {
                STYLE_CLASS: B,
                TEXT_ALIGN: "center",
                DATA: d(o.baseDataHTML, {
                    DATA: s
                })
            }))
        }
        for (var y = 0, E = F.columns.length; y < E; y++) {
            var x = F.columns[y],
                u;
            if (x.visible === false) {
                continue
            }
            var t = x.id,
                z = A[t] !== undefined ? (A[t] + "").replace(/\n/g, "<br/>") : "&nbsp;",
                r = w ? false : x.linkable;
            if (r && F.linkDecisionFunc) {
                r = F.linkDecisionFunc.call(this, A, z, t)
            }
            if (r) {
                u = d(o.linkableDataCell, {
                    COLUMN_ID: t,
                    DATA: d(o.baseDataHTML, {
                        DATA: z
                    })
                })
            } else {
                u = d(o.baseDataHTML, {
                    DATA: z
                })
            }
            if (x.align && /(right|left|center)/i.test(x.align)) {
                v = x.align
            }
            D.push(d(C, {
                STYLE_CLASS: B,
                TEXT_ALIGN: v,
                DATA: u
            }))
        }
        if (F.editable) {
            D.push(d(o.editCell, {
                EDIT_LABEL: F.editLabel
            }))
        }
        return D
    }

    function c(r) {
        var s = [];
        for (var w = 0, u = r.rowNumOptions.length; w < u; w++) {
            var v = r.rowNumOptions[w],
                t = v == r.rowNum ? o.selectedOption : o.baseOption;
            s.push(d(t, {
                VALUE: v,
                LABEL: v
            }))
        }
        return {
            LIST_OPTION: d(o.footerHTML, {
                COL_SPAN: r.colSpan,
                OPTIONS: s.join("")
            })
        }
    }

    function l(D, s, B) {
        var t = Math.ceil(B / D.rowNum),
            r = Math.max(1, (s - Math.floor(D.pagingNum / 2))),
            x = Math.min(t, (r + D.pagingNum - 1));
        if (x - r < D.pagingNum) {
            r = Math.max(1, ((x - D.pagingNum + 1)))
        }
        var y = [],
            u = r,
            C = x + 1;
        y.push({
            label: D.pagingFirstLabel,
            index: 1,
            current: false
        });
        y.push({
            label: D.pagingPreviousLabel,
            index: Math.max(1, (s - 1)),
            current: false
        });
        for (; u < C; u++) {
            y.push({
                label: "" + u,
                index: u,
                current: (u == s)
            })
        }
        y.push({
            label: D.pagingNextLabel,
            index: Math.min(x, (s + 1)),
            current: false
        });
        y.push({
            label: D.pagingLastLabel,
            index: t,
            current: false
        });
        var w = [],
            A = y.length;
        if (A > 4) {
            for (u = 0, C = A; u < C; u++) {
                var v = y[u],
                    z = v.current ? o.currentPagingHTML : o.pagingHTML;
                w.push(d(z, {
                    INDEX: v.index,
                    LABEL: v.label
                }))
            }
        }
        return w
    }

    function a(v, s, r) {
        var t = 0,
            u;
        if (g.isArray(v.extraParam)) {
            u = g.merge([{
                name: "pageIndex",
                value: s
            }, {
                name: "rowNum",
                value: v.rowNum
            }], v.extraParam)
        } else {
            u = g.extend({
                pageIndex: s,
                rowNum: v.rowNum
            }, v.extraParam)
        }
        g.ajax({
            type: "POST",
            url: v.loaderURL,
            data: u,
            hideLoading: true,
            success: function(w) {
                if (w.paginatedData) {
                    t = w.paginatedData["totalCount"];
                    r.tableBody.html((i(v, w.paginatedData["rowData"], t, s))["LIST_BODY"]);
                    r.pagingWrap.html(l(v, s, t));
                    r.currentData = w.paginatedData["rowData"];
                    r.currentPage = s
                } else {
                    r.tableBody.html(i(v, [], t, s));
                    r.pagingWrap.empty();
                    r.currentData = [];
                    r.currentPage = 0
                }
                p.storePageIndex(v.loaderURL, s)
            },
            dataType: "json"
        })
    }
    var n = {};

    function b(s, C, w, v, u) {
        var D;
        var y = {},
            r = w.id;
        switch (w.filter) {
            case "LIKE":
                var B = "";
                if (n[r]) {
                    B = n[r]
                }
                D = g(d(o.filterLike, {
                    BEFORE: B
                }));
                var A = function() {
                    var E = D.find("input"),
                        F = g.trim(E.val());
                    if (F.length == 0) {
                        alert("Please enter filter keyword");
                        return
                    }
                    k(C, r, [F], function() {
                        n[r] = F;
                        u.call(this, true)
                    });
                    s.popoverdialog("close")
                };
                y.Filter = A;
                y.Clear = function() {
                    var E = D.find("input");
                    E.val("");
                    k(C, r, [""], function() {
                        n[r] = undefined;
                        u.call(this, false)
                    });
                    s.popoverdialog("close")
                };
                D.on("keyup", "input", function(E) {
                    if (E.keyCode == 13) {
                        A()
                    }
                });
                if (B.length == 0 && w.filtered) {
                    f(C, r, function(F) {
                        if (F.length > 0) {
                            var E = D.find("input");
                            if (E.length > 0) {
                                E.val(F[0]["code"]);
                                n[r] = F[0]["code"]
                            }
                        }
                    })
                }
                break;
            case "SEARCH":
            case "SELECT":
                var x = true,
                    t;
                if (n[r]) {
                    t = j(n[r], w.filtered);
                    x = false
                } else {
                    t = j([], w.filtered)
                }
                var z = d(t.allChecked ? o.checkedCheckbox : o.baseCheckbox, {
                    VALUE: "",
                    LABEL: v
                });
                D = g(d(o.filterSelect, {
                    ALL_CHECKBOX: z,
                    OPTION_CHECKBOXES: t.options
                }));
                y.Filter = function() {
                    if (D.find("tr:eq(0)").find("input").prop("checked")) {
                        k(C, r, [""], function() {
                            for (var J = 0, I = n[r].length; J < I; J++) {
                                n[r][J]["checked"] = true
                            }
                            u.call(this, false)
                        });
                        s.popoverdialog("close")
                    } else {
                        var F = D.find("tr:eq(1)").find("input").filter(function() {
                            return this.checked
                        });
                        var G = [];
                        for (var H = 0, E = F.length; H < E; H++) {
                            G.push(F[H].value)
                        }
                        if (G.length == 0) {
                            alert("Please select filter option");
                            return
                        }
                        k(C, r, G, function() {
                            for (var M = 0, L = n[r].length; M < L; M++) {
                                var K = false;
                                for (var J = 0, I = G.length; J < I; J++) {
                                    if (G[J] == n[r][M]["code"]) {
                                        K = true;
                                        break
                                    }
                                }
                                n[r][M]["checked"] = K
                            }
                            u.call(this, true)
                        });
                        s.popoverdialog("close")
                    }
                };
                if (x) {
                    f(C, r, function(F) {
                        t = j(F, w.filtered);
                        var E = D.find("tr");
                        if (t.allChecked) {
                            E.eq(0).find("input").prop("checked", true)
                        }
                        E.eq(1).find("td > div").append(t.options);
                        n[r] = F
                    })
                }
                D.on("click", "tr:eq(0) input", function() {
                    var E = D.find("tr:eq(0) input");
                    if (E.prop("checked")) {
                        D.find("tr:eq(1) input").prop("checked", true)
                    } else {
                        D.find("tr:eq(1) input").prop("checked", false)
                    }
                });
                D.on("click", "tr:eq(1) input", function() {
                    var F = D.find("tr:eq(1) input");
                    var E = F.filter(function() {
                        return !this.checked
                    });
                    if (E.length > 0 || F.length == 0) {
                        D.find("tr:eq(0) input").prop("checked", false)
                    } else {
                        D.find("tr:eq(0) input").prop("checked", true)
                    }
                });
                break
        }
        y.Cancel = function() {
            s.popoverdialog("close")
        };
        s.popoverdialog({
            widthFitContent: true,
            content: D,
            buttons: y
        })
    }

    function f(s, r, t) {
        g.ajax({
            type: "POST",
            url: "/paginated/filters.json",
            data: {
                property: s,
                column: r
            },
            hideLoading: true,
            success: function(u) {
                t.call(this, u.filters)
            },
            dataType: "json"
        })
    }

    function k(u, t, s, x) {
        var v = [{
            name: "property",
            value: u
        }, {
            name: "column",
            value: t
        }];
        for (var w = 0, r = s.length; w < r; w++) {
            v.push({
                name: "code",
                value: s[w]
            })
        }
        g.ajax({
            type: "POST",
            url: "/paginated/filtering.json",
            data: v,
            hideLoading: true,
            success: function(y) {
                x.call(this)
            },
            dataType: "json"
        })
    }

    function j(y, x) {
        var s = [],
            z = y.length,
            u = z > 0;
        for (var r = 0; r < z; r++) {
            var t = y[r];
            var v = !x || t.checked;
            var w = v ? o.checkedCheckbox : o.baseCheckbox;
            s.push(d(w, {
                VALUE: t.code,
                LABEL: t.label
            }));
            u = u && v
        }
        return {
            allChecked: u,
            options: s.join("")
        }
    }
})(jQuery);
(function(c) {
    var b;

    function a() {
        this._layerId = "popover";
        this._popoverShowing = false;
        this._currentTarget = null;
        this.propertyName = "popoverdialog";
        this.defaults = {
            title: undefined,
            content: undefined,
            alerts: [],
            buttons: {},
            close: undefined,
            width: 300,
            widthFitContent: false,
            offset: undefined,
            offsetFix: undefined
        };
        this.options = {};
        this.layerWrap = c("<div></div>").attr("id", this._layerId).addClass("layer-wrap").css({
            display: "none",
            top: "0px",
            left: "0px"
        });
        this.layerPd = c("<div></div>").addClass("layer-pd").appendTo(this.layerWrap);
        this.layerTopPane = c("<div></div>").addClass("layer-top-area").appendTo(this.layerPd);
        this.layerTitle = c("<div></div>").addClass("left").appendTo(this.layerTopPane);
        this.layerContentPane = c("<div></div>").appendTo(this.layerPd);
        this.layerAlertPane = c("<div></div>").addClass("layer-alert").css("display", "none").appendTo(this.layerPd);
        this.layerButtonPane = c("<div></div>").addClass("layer-btn").appendTo(this.layerPd)
    }
    c.extend(a.prototype, {
        open: function(g, d) {
            if (this._popoverShowing) {
                var f = (g && g.data(this.propertyName) == this);
                this.close();
                if (f) {
                    return
                }
            }
            this.options = {};
            c.extend(this.options, this.defaults, d);
            this._updateLayerPane(true, true);
            c(document.body).append(this.layerWrap);
            this.layerWrap.css({
                top: "0",
                left: "0"
            }).show();
            this._position(g);
            this._popoverShowing = true;
            var e = this.layerContentPane.find('input[type="text"],textarea').filter(":visible");
            if (e.length > 0) {
                e[0].focus()
            }
            var h = this.layerContentPane.find(".nano");
            if (h.length > 0 && c.fn.hasOwnProperty("nanoScroller")) {
                h.nanoScroller().children(".pane").css({
                    padding: "0"
                })
            }
            if (g) {
                g.data(this.propertyName, this);
                this._currentTarget = g
            }
        },
        close: function() {
            this._closeHandler.apply()
        },
        refresh: function(e, d) {
            c.extend(this.options, d);
            this._updateLayerPane(d.content, d.alerts);
            this._position(e)
        },
        _position: function(i) {
            if (this.options.widthFitContent) {
                this.layerWrap.css("width", c(window).width() + "px");
                this.layerPd.css("float", "left");
                var h = this.layerPd.find('table[width="100%"]');
                h.removeAttr("width");
                var f = this.layerPd.children("div:visible").not(".layer-btn");
                f.css("display", "inline");
                this.layerWrap.css("width", (this.layerPd.outerWidth() + 2) + "px");
                this.layerPd.css("float", "");
                f.css("display", "");
                h.attr("width", "100%")
            } else {
                this.layerWrap.css("width", this.options.width + "px")
            }
            if (this.options.offset) {
                if (this.options.offset.left) {
                    this.layerWrap.css({
                        left: this.options.offset.left + "px",
                        right: ""
                    })
                } else {
                    if (this.options.offset.right) {
                        this.layerWrap.css({
                            right: this.options.offset.right + "px",
                            left: ""
                        })
                    } else {
                        this.layerWrap.css({
                            left: Math.floor((c(window).width() - this.layerWrap.outerWidth()) / 2) + "px",
                            right: ""
                        })
                    }
                }
                if (this.options.offset.top) {
                    this.layerWrap.css("top", this.options.offset.top + "px")
                } else {
                    this.layerWrap.css("top", "0px")
                }
            } else {
                if (i) {
                    var e, d;
                    e = c(i);
                    d = this.layerWrap;
                    if (e.parents("#bottom-wrap").length == 0) {
                        var g = ["left"];
                        if (this.options.offsetFix && this.options.offsetFix.left) {
                            g.push(this.options.offsetFix.left)
                        }
                        g.push(" top");
                        if (this.options.offsetFix && this.options.offsetFix.top) {
                            g.push(this.options.offsetFix.top)
                        }
                        d.position({
                            of: e,
                            my: g.join(""),
                            at: "left bottom"
                        })
                    } else {
                        d.position({
                            of: e,
                            my: "left bottom",
                            at: "left top"
                        })
                    }
                    if (e.closest(".nano").length > 0) {
                        e.closest(".nano .content").bind("scroll", function() {
                            d.position({
                                of: e,
                                my: "left bottom",
                                at: "left top"
                            })
                        })
                    }
                } else {
                    this.layerWrap.position({
                        of: window,
                        my: "center center",
                        at: "center center"
                    })
                }
            }
        },
        _closeHandler: function(d) {
            if (b._currentTarget) {
                b._currentTarget.removeData(b.propertyName);
                b._currentTarget = null
            }
            b.layerWrap.hide().css({
                top: "0",
                left: "0",
                right: ""
            });
            b._popoverShowing = false;
            if (c.isFunction(b.options.close)) {
                b.options.close.apply()
            }
        },
        _updateLayerPane: function(j, f) {
            var e;
            e = this.options;
            if (e.title && c.type(e.title) == "string" && c.trim(e.title) != "") {
                this.layerTitle.empty().html(e.title).show();
                this.layerTopPane.show()
            } else {
                if (e.title && c.isEmptyObject(e.title) == false && e.title.length > 0) {
                    this.layerTitle.empty().append(e.title).show();
                    this.layerTopPane.show()
                } else {
                    this.layerTopPane.hide()
                }
            }
            if (e.content) {
                if (j) {
                    if (typeof e.content == "string") {
                        this.layerContentPane.html(e.content)
                    } else {
                        this.layerContentPane.children().remove();
                        this.layerContentPane.append(e.content)
                    }
                    this.layerContentPane.show()
                }
            } else {
                this.layerContentPane.hide()
            }
            if (e.alerts && e.alerts.length > 0) {
                if (f) {
                    var h = [];
                    for (var g = 0, d = e.alerts.length; g < d; g++) {
                        h.push('<img src="/resources/image/alert.png" alt="alert" /> <span>'.concat(e.alerts[g], "</span>"))
                    }
                    this.layerAlertPane[0].innerHTML = h.join("<br/>");
                    this.layerAlertPane.css("display", "block")
                }
            } else {
                this.layerAlertPane.css("display", "none")
            }
            if (e.buttons && c.isEmptyObject(e.buttons) == false) {
                var g = 0;
                this.layerButtonPane.children().remove();
                c.each(e.buttons, function(i, k) {
                    if (g > 0) {
                        c("<span>&nbsp;</span>").appendTo(b.layerButtonPane)
                    }
                    c("<input />").attr({
                        type: "button",
                        value: i
                    }).click(function(l) {
                        k.call(b, l, b.layerContentPane)
                    }).appendTo(b.layerButtonPane).button();
                    g++
                });
                this.layerButtonPane.show()
            } else {
                this.layerButtonPane.hide()
            }
        },
        _checkExternalClick: function(e) {
            var d = c(e.target);
            if (d.attr("id") != b._layerId && d.parents("#" + b._layerId).length == 0 && !(b._currentTarget && d.data(b.propertyName) == b) && b._popoverShowing && (b.options.forceExternalCheck == undefined || b.options.forceExternalCheck.apply(this, [e]) == false)) {
                b._closeHandler(e)
            }
        }
    });
    c.fn.popoverdialog = function(e) {
        if (!this.length) {
            return this
        }
        if (!b.initialized) {
            c(document).mousedown(b._checkExternalClick).find(document.body).append(b.layerWrap);
            b.initialized = true
        }
        var d = Array.prototype.slice.call(arguments, 1);
        if (typeof e == "string") {
            if (e == "close") {
                b.close()
            } else {
                b[e].apply(b, [this].concat(d))
            }
        } else {
            b.open(this, e)
        }
        return this
    };
    c.popoverdialog = function(e) {
        if (!b.initialized) {
            c(document).mousedown(b._checkExternalClick).find(document.body).append(b.layerWrap);
            b.initialized = true
        }
        var d = Array.prototype.slice.call(arguments, 1);
        if (typeof e == "string") {
            if (e == "close") {
                b.close()
            } else {
                b[e].apply(b, [null].concat(d))
            }
        } else {
            b.open(null, e)
        }
    };
    b = new a();
    b.initialized = false
}(jQuery));
(function(a) {
    a.widget("roman.select", {
        options: {
            minWidth: 150,
            paddingLR: 20
        },
        _create: function() {
            var e, d, g, b;
            e = this.element.parent().width() - this.options.paddingLR;
            d = this.element.is(":disabled");
            this.groupDelimiter = this.element.attr("data-group");
            g = this.element.find('option:selected:not([data-type="notselect"])');
            this.placeholder = this.element.find('option[data-type="notselect"]:eq(0)').html();
            if (this.element.find("option[data-other]").length > 0) {
                this.otherHidden = this.element.closest("td").find('input:hidden[data-type="dropdown-other"]')
            }
            this.widget = a("<div></div>").addClass("select-wrap").insertAfter(this.element);
            this.selectText = a("<div></div>").addClass("select-text").appendTo(this.widget);
            this.text = a("<div></div>").css({
                "text-align": "left"
            }).appendTo(this.selectText);
            this.selectBtn = a("<div></div>").addClass("select-btn").appendTo(this.widget);
            this.button = a("<input />").attr({
                type: "button",
                value: "▼"
            }).css({
                height: "100%"
            }).appendTo(this.selectBtn).button({
                disabled: d
            });
            this.originWidth = this.element.css("width", "").outerWidth() * 1.2;
            this.width = Math.ceil(Math.min(e, this.originWidth));
            this.selectedLabel = (g.length == 1 ? (g.attr("label") || g.html()) : "");
            var c = undefined;
            if (g.is("[data-other]") && (c = this.otherHidden.filter('[data-relate="' + g.val() + '"]'))) {
                this.selectedLabel += " (" + c.val() + ")"
            }
            this.textBorderUD = this.selectText.outerHeight() - this.selectText.height();
            this.textBorderLR = this.selectText.outerWidth() - this.selectText.width();
            this.element.hide();
            if (this.selectedLabel == "" && this.placeholder != "") {
                this.text.addClass("placeholder").html(this.placeholder)
            } else {
                this.text.html(this.selectedLabel).removeClass("placeholder")
            }
            this.widget.css({
                display: "inline-block",
                width: this.width + "px"
            });
            this.selectText.css({
                width: (this.width - this.selectBtn.outerWidth() - this.textBorderLR) + "px"
            });
            this._fixLayout();
            this.widget.click(a.proxy(this._openSelectLayer, this));
            var f = this;
            f.element.on("change:dvsentry", function() {
                var h = f.element.find("option:selected");
                if (h.length == 0 || h.is('[data-type="notselect"]')) {
                    f.clear()
                } else {
                    if (h.is("[data-other]")) {
                        f.text.html(h.html() + "( )").removeClass("placeholder")
                    } else {
                        f.text.html(h.html()).removeClass("placeholder")
                    }
                }
                return false
            })
        },
        _setOption: function(b, c) {
            switch (b) {}
        },
        disabled: function(b) {
            this.button.button("option", "disabled", b)
        },
        reset: function() {
            if (this.selectedLabel == "" && this.placeholder != "") {
                this.text.html(this.placeholder).addClass("placeholder")
            } else {
                this.text.html(this.selectedLabel).removeClass("placeholder")
            }
            this._fixLayout()
        },
        _initialize: function(b) {
            b.element.find('option[data-type="notselect"]').prop("selected", true);
            if (b.otherHidden) {
                b.otherHidden.val("")
            }
            b.clear();
            b.widget.popoverdialog("close")
        },
        clear: function() {
            if (this.placeholder != "") {
                this.text.addClass("placeholder").html(this.placeholder);
                this._fixLayout()
            } else {
                this.text.html("&nbsp;");
                this._fixLayout();
                this.text.html("")
            }
            if (this.otherHidden) {
                this.otherHidden.val("")
            }
        },
        destory: function() {
            this.widget.remove();
            this.element.show();
            a.Widget.prototype.destroy.call(this)
        },
        _openSelectLayer: function(r) {
            if (this.element.is(":disabled") || this.element.data("deleted") == true) {
                return false
            }
            var o, f, x, w, p, d, c;
            o = this;
            d = a("<div></div>").css({
                visibility: "hidden",
                position: "absolute",
                top: "0",
                left: "0"
            }).appendTo(document.body);
            f = a("<div></div>").addClass("layer-contents");
            x = a("<div></div>").addClass("content");
            c = this.element.find("option");
            var m = {},
                z = (o.groupDelimiter != undefined && o.groupDelimiter != "");
            a.each(c, function(E, D) {
                var O, N, K, I, G, M, J, L, C;
                K = a(D);
                if (K.is('[data-type="notselect"]')) {
                    if (K.html().length > 0) {
                        a("<div></div>").addClass("option-default").html(K.html()).appendTo(f)
                    }
                } else {
                    J = K.attr("label");
                    if (!J && J.length == 0) {
                        J = K.html()
                    }
                    if (z) {
                        var F = J.indexOf(o.groupDelimiter);
                        if (F > -1) {
                            L = J.substring(0, F);
                            J = a.trim(J.substring(F + o.groupDelimiter.length))
                        }
                    }
                    N = a("<div></div>").addClass("pt5").html(J);
                    I = K.is("[data-other]");
                    if (I) {
                        C = o.otherHidden.filter('[data-relate="' + K.val() + '"]');
                        if (C.length == 1) {
                            G = a("<input />").attr({
                                name: C.attr("name"),
                                type: "text"
                            }).css({
                                width: "200px",
                                "margin-left": "5px"
                            }).appendTo(N).keyup(function(i) {
                                if (i.keyCode == 13) {
                                    o.text.html(K.html() + " (" + G.val() + ")");
                                    if (C.length > 0) {
                                        C.val(G.val())
                                    }
                                    o.widget.popoverdialog("close");
                                    c.removeAttr("selected");
                                    K.prop("selected", true);
                                    o._fixLayout();
                                    o.element.trigger(a.Event("change"))
                                }
                            });
                            G.val(C.val());
                            if (o.otherHidden.is('[data-input="medcod"]')) {
                                var H = a("#crfpage_form").attr("action");
                                H = H.replace(/^\/([^\/]+)\/([^\/]+)\//i, "/$1/medical-coding/");
                                var g = C.attr("name");
                                g = g.replace(/item_\d+_(\d+)_\d+(_\d+)?/, "$1");
                                G.medicalcoding({
                                    baseUrl: H,
                                    itemKey: g
                                });
                                G.prop("readonly", true)
                            }
                        }
                    }
                    if (K.is(":selected")) {
                        N.append(' <img src="/images/selected-opt.png" alt="selected" />')
                    }
                    O = a('<a href="#"></a>').append(N).click(function(P) {
                        var i = a(P.target);
                        if (i.is("input")) {
                            return P.stopPropagation()
                        }
                        if (I) {
                            o.text.html(J + " (" + (G !== undefined ? G.val() : "") + ")").removeClass("placeholder");
                            if (C.length > 0) {
                                C.val(G.val())
                            }
                        } else {
                            o.text.html(J).removeClass("placeholder");
                            if (C && C.length > 0) {
                                C.val("")
                            }
                        }
                        o.widget.popoverdialog("close");
                        c.removeAttr("selected");
                        K.attr("selected", "selected");
                        o._fixLayout();
                        o.element.trigger(a.Event("change"))
                    });
                    if (L) {
                        if (m[L] == undefined) {
                            m[L] = a([])
                        }
                        a.merge(m[L], O)
                    } else {
                        d.append(O)
                    }
                }
            });
            if (a.isEmptyObject(m) == false) {
                var e = a("<table></table>").attr({
                    border: "0",
                    cellpadding: "0",
                    cellspacing: "0",
                    width: "100%"
                }).addClass("layer-table1");
                var l = 0,
                    h = [];
                var q = a("<colgroup></colgroup>"),
                    y = a("<tr></tr>");
                a.each(m, function(i, g) {
                    if (g.length > 0) {
                        h.push(i);
                        l = Math.max(l, g.length);
                        y.append('<th style="text-align:left;">' + a.trim(i) + "</th>")
                    }
                });
                var j = h.length,
                    k = 100 / j;
                for (var s = 0; s < l; s++) {
                    a('<col width="' + k + '%" />').appendTo(q)
                }
                e.append(q).append(y);
                for (var s = 0; s < l; s++) {
                    var A = a("<tr></tr>").appendTo(e);
                    for (var u = 0; u < j; u++) {
                        var B = m[h[u]][s];
                        if (B) {
                            a("<td></td>").append(B).appendTo(A)
                        } else {
                            a("<td></td>").append("&nbsp;").appendTo(A)
                        }
                    }
                }
                d.append(e)
            }
            var b = o.widget.offsetParent();
            var t = o.widget.offset().top - b.offset().top;
            var n = b.height() - t - o.widget.outerHeight();
            var p = d.outerHeight() + 95;
            if (p > t && p > n) {
                p = Math.max(t, n)
            }
            p -= 95;
            w = d.outerWidth() + 40;
            f.append(x.append(d.children()));
            x.wrap(a("<div></div>").addClass("select-scroll nano").css({
                height: p + "px",
                "max-height": p + "px",
                "overflow-y": "hidden"
            }));
            d.remove();
            w = Math.max(w, o.options.minWidth);
            var v = undefined;
            if (o.otherHidden && o.otherHidden.is('[data-input="medcod"]')) {
                v = function(i) {
                    var g = a(i.target);
                    if (a("#medicalcoding").find(g).length > 0) {
                        return true
                    }
                    return false
                }
            }
            o.widget.popoverdialog({
                showCloser: true,
                content: f,
                width: w,
                buttons: {
                    "초기화": function(g) {
                        o._initialize(o)
                    },
                    "취소": function(g) {
                        o.widget.popoverdialog("close")
                    }
                },
                forceExternalCheck: v
            });
            return false
        },
        _fixLayout: function() {
            var b;
            b = this.text.outerHeight() + this.textBorderUD;
            if (b < 10) {
                b = this.selectBtn.outerHeight()
            }
            this.widget.css("height", b + "px");
            this.selectText.css("height", (b - this.textBorderUD) + "px");
            this.selectBtn.css("height", b + "px");
            if (/MSIE 7.0/gi.test(navigator.userAgent)) {
                this.selectBtn.children("input").css("height", b + "px")
            }
        }
    })
}(jQuery));
(function(c) {
    var b, d;
    d = "timepicker";

    function a() {
        this.markerClassName = "hasTimepicker";
        this._pickerId = "timepicker";
        this._timepickerShowing = false;
        this._currElement = null;
        this._timeObj = {
            hh: "",
            mm: "",
            m: ""
        };
        this._selectedObj = {
            hh: null,
            mm: null,
            m: null
        };
        this.defaults = {};
        this.options = {
            delimiter: ":"
        };
        this.pickerDiv = c('<div id="' + this._pickerId + '"></div>').addClass("ui-timepicker ui-widget ui-widget-content ui-helper-clearfix ui-corner-all");
        this.nanoDiv = c("<div></div>").addClass("nano").append(this.contentDiv = c("<div></div>").addClass("content")).appendTo(this.pickerDiv)
    }
    c.extend(a.prototype, {
        _attachTimepicker: function(f, e) {
            f.addClass(this.markerClassName).click(function(j) {
                var h = c(j.currentTarget);
                if (b._timepickerShowing && h.data(d) == b) {
                    return false
                }
                if (h.data("deleted") == true) {
                    return false
                }
                h.data(d, b);
                b._setTime(h, b.pickerDiv, b._timeObj, b.options.delimiter);
                b._timepickerShowing = true;
                b._currElement = h;
                if (f.is('[data-hhuk="Y"]')) {
                    b.hhuk.css("display", "")
                } else {
                    b.hhuk.css("display", "none")
                }
                if (f.is('[data-mmuk="Y"]')) {
                    b.mmuk.css("display", "")
                } else {
                    b.mmuk.css("display", "none")
                }
                c(document.body).append(b.pickerDiv);
                b.pickerDiv.css({
                    position: "absolute",
                    left: "0",
                    top: "0"
                }).show();
                var g = b.contentDiv.children(".ui-timepicker-hour").outerHeight() + 50;
                var i = g;
                i -= 50;
                b.nanoDiv.css("height", i + "px");
                b.nanoDiv.nanoScroller();
                b.pickerDiv.position({
                    at: "left bottom",
                    my: "left top",
                    of: h
                });
                return false
            })
        },
        _closeHandler: function(e) {
            if (b._timepickerShowing == false) {
                return false
            }
            if (!b._timeObj.hh) {
                b._timeObj.hh = "00"
            }
            if (!b._timeObj.mm) {
                b._timeObj.mm = "0"
            }
            if (!b._timeObj.m && b._timeObj.mm != "UK") {
                b._timeObj.m = "0"
            }
            b._setTimeText(b._currElement, b._timeObj, b.options.delimiter);
            b.pickerDiv.hide();
            b._timepickerShowing = false;
            b._currElement.removeData(d);
            b._currElement.trigger(c.Event("close.timepicker"));
            b._currElement = null;
            b._timeObj = {
                hh: "",
                mm: "",
                m: ""
            }
        },
        _clearHandler: function(e) {
            if (b._timepickerShowing == false) {
                return false
            }
            b._currElement.val("");
            b._timeObj = {
                hh: "",
                mm: "",
                m: ""
            };
            b.pickerDiv.find(".ui-timepicker-hour,.ui-timepicker-min").find(".ui-state-active").removeClass("ui-state-active");
            b.pickerDiv.hide();
            b._timepickerShowing = false;
            b._currElement.removeData(d);
            b._currElement = null
        },
        _setTime: function(k, i, l, e) {
            var j = k.val(),
                g, n;
            i.find(".ui-state-active").removeClass("ui-state-active");
            if ((c.trim(j)).length == 0) {
                return {
                    hh: "",
                    mm: "",
                    m: ""
                }
            }
            j = j.split(e);
            if (j[0]) {
                g = parseInt(j[0].replace(/[^0-9]/g, ""), 10);
                n = i.find('.ui-timepicker-hour td[data-hh="' + g + '"]');
                n = n.children("a").addClass("ui-state-active");
                b._selectedObj.hh = n;
                b._timeObj.hh = n.html()
            }
            if (j[1]) {
                j[1] = j[1].replace(/[^0-9]/g, "");
                var h, f;
                if (j[1].length > 1) {
                    h = j[1].substr(0, 1);
                    f = j[1].substr(1, 1)
                } else {
                    if (j[1].length == 1) {
                        f = j[1]
                    }
                }
                if (h) {
                    n = i.find('.ui-timepicker-min td[data-mm="' + h + '"]');
                    n = n.children("a").addClass("ui-state-active");
                    b._selectedObj.mm = n;
                    b._timeObj.mm = n.html()
                }
                if (f) {
                    n = i.find('.ui-timepicker-min td[data-m="' + f + '"]');
                    n = n.children("a").addClass("ui-state-active");
                    b._selectedObj.m = n;
                    b._timeObj.m = n.html()
                }
            }
        },
        _generateHourHTML: function(g, k) {
            var e = ['<table class="ui-timepicker-hour">'];
            for (var j = 0; j < 12; j++) {
                e.push("<tr>");
                e.push('<td data-pos="hh" data-hh="' + j + '"><a href="#" onclick="return false;" class="ui-state-default">');
                e.push(b._lpadNumber(j));
                e.push("</a></td>");
                e.push('<td data-pos="hh" data-hh="' + (j + 12) + '"><a href="#" onclick="return false;" class="ui-state-default">');
                e.push(b._lpadNumber(j + 12));
                e.push("</a></td>");
                e.push("</tr>")
            }
            e.push('<tr><td data-pos="hh" data-hh="UK" colspan="2"><a href="#" onclick="return false;" class="ui-state-default">UK</a></td></tr>');
            e.push("</table>");
            var f = ['<div class="ui-timepicker-hour">', '<div class="ui-timepicker-header ui-widget-header ui-helper-clearfix ui-corner-all">', '<div class="ui-timepicker-title"><span>', k, "</span>", "</div>", "</div>", e.join(""), "</div>"];
            var h = c(f.join(""));
            h.on("click", 'td[data-pos="hh"] a', c.proxy(b._clickTimeHandler, b));
            this.hhuk = h.find("tr:last");
            return h
        },
        _generateMinHTML: function(f, k) {
            var e = ['<table class="ui-timepicker-min">'];
            for (var j = 0; j < 12; j++) {
                e.push("<tr>");
                if (j < 6) {
                    e.push('<td data-pos="mm" data-mm="' + j + '"><a href="#" onclick="return false;" class="ui-state-default">');
                    e.push(j);
                    e.push("</a></td>")
                } else {
                    e.push('<td class="ui-state-disabled"><span class="ui-state-default">&nbsp;</span></td>')
                }
                if (j < 10) {
                    e.push('<td data-pos="m" data-m="' + j + '"><a href="#" onclick="return false;" class="ui-state-default">');
                    e.push(j);
                    e.push("</a></td>")
                } else {
                    e.push('<td class="ui-state-disabled"><span class="ui-state-default">&nbsp;</span></td>')
                }
                e.push("</tr>")
            }
            e.push('<tr><td data-pos="mm" data-mm="UK" colspan="2"><a href="#" onclick="return false;" class="ui-state-default">UK</a></td></tr>');
            e.push("</table>");
            var g = ['<div class="ui-timepicker-min">', '<div class="ui-timepicker-header ui-widget-header ui-helper-clearfix ui-corner-all">', '<div class="ui-timepicker-title"><span>', k, "</span>", "</div>", "</div>", e.join(""), "</div>"];
            var h = c(g.join(""));
            h.on("click", 'td[data-pos="mm"] a, td[data-pos="m"] a', c.proxy(b._clickTimeHandler, b));
            this.mmuk = h.find("tr:last");
            return h
        },
		
        _generateButtons: function() {
            var e;
            e = c("<div></div>").addClass("ui-timepicker-buttonpane ui-widget-content");
            c("<button></button>").attr({
                "data-handler": "hide"
            }).addClass("ui-timepicker-close ui-state-default ui-priority-primary ui-corner-all").html("닫기").click(c.proxy(b._closeHandler, b)).appendTo(e);
            c("<button></button>").attr({
                "data-handler": "hide"
            }).addClass("ui-timepicker-current ui-state-default ui-priority-primary ui-corner-all").html("Clear").click(c.proxy(b._clearHandler, b)).appendTo(e);
            return e
        },
		
        _lpadNumber: function(e) {
            return e < 10 ? "0" + e : e
        },
        _clickTimeHandler: function(h) {
            var f, e, g;
            f = c(h.target);
            g = false;
            if (f.is(".ui-state-active")) {
                return false
            }
            e = f.parent().attr("data-pos");
            if (e == "mm" && f.parent().attr("data-mm") == "UK") {
                g = true
            }
            if (this._selectedObj[e]) {
                this._selectedObj[e].removeClass("ui-state-active");
                if (g && this._selectedObj.m) {
                    this._selectedObj.m.removeClass("ui-state-active")
                } else {
                    if (e == "m" && this._selectedObj.mm && this._selectedObj.mm.parent().attr("data-mm") == "UK") {
                        this._selectedObj.mm = undefined;
                        this._timeObj.mm = ""
                    }
                }
            }
            f.addClass("ui-state-active");
            this._selectedObj[e] = f;
            if (g) {
                this._selectedObj.m = f
            }
            this._timeObj[e] = f.html();
            if (g) {
                this._timeObj.m = ""
            }
            this._setTimeText(this._currElement, this._timeObj, this.options.delimiter);
            return false
        },
        _setTimeText: function(f, g, e) {
            f.val(g.hh + e + g.mm + g.m)
        },
        _checkExternalClick: function(f) {
            var e = c(f.target);
            if (b._timepickerShowing && e.attr("id") != b._pickerId && e.parents("#" + b._pickerId).length == 0 && e.data(d) != b) {
                b._closeHandler(f)
            }
        }
    });
    c.fn.timepicker = function(f) {
        if (!this.length) {
            return this
        }
        if (!b.initialized) {
            c(document).mousedown(b._checkExternalClick).find(document.body).append(b.pickerDiv);
            c(window).resize(b._closeHandler);
            b.contentDiv.append(b._generateHourHTML(0, "시")).append(b._generateMinHTML(0, "분"));
            b.pickerDiv.append(b._generateButtons());
            b.initialized = true
        }
        var e = Array.prototype.slice.call(arguments, 1);
        if (typeof f == "string") {
            b[f].apply(b, [this].concat(e))
        } else {
            b._attachTimepicker(this, f)
        }
        return this
    };
    b = new a();
    b.initialized = false
}(jQuery));
(function(e) {
    var q = document.initializerModel || {};
    var a = "_item-row-runtime-wrap",
        d = "_blind-only-item",
        A = "_need-fileupload";
    var z = {
        html: {
            defaultOption: '<option value="#{VALUE}#">#{LABEL}#</option>',
            selectedOption: '<option value="#{VALUE}#" selected="selected">#{LABEL}#</option>',
            categoryItem: '<a href="#{LINK}#"#{ID_ATTR}#><div class="top-navi-#{STATUS}#"><strong>#{LABEL}#</strong> <span>▶</span></div></a>',
            englishNotation: '<div class="item-eng" data-itemkey="#{ITEM}#">#{CONTENT}#</div>',
            notationItems: '<div class="pb10"><select id="notation-items" style="width:100%;">#{NOTATION_ITEM_OPTIONS}#</select></div>',
            inputNotation: "".concat('<div class="_notation-wrap"#{WRAP_STYLE}#>', '<div class="left" style="width:48%;"><span class="layer-tab">#{SOURCE_LABEL}#</span><div class="input-text"><div><input type="text" value="#{SOURCE_CONTENT}#" readonly="readonly"/></div></div></div>', '<div class="right" style="width:48%;"><span class="layer-tab">#{NOTATION_LABEL}#</span><div class="input-text"><div><input type="text" id="notation-#{ITEM_ID}#" maxlength="#{MAX_LENGTH}#" value="#{NOTATION_CONTENT}#" style="width:100%;"/><input type="hidden" name="origin" value="#{ORIGIN_CONTENT}#" /></div></div></div>', '<div class="clear"></div>', "</div>"),
            textareaNotation: "".concat('<div class="_notation-wrap"#{WRAP_STYLE}#>', '<div class="left" style="width:48%;"><span class="layer-tab">#{SOURCE_LABEL}#</span><div class="input-area">#{SOURCE_CONTENT}#</div></div>', '<div class="right" style="width:48%;"><span class="layer-tab">#{NOTATION_LABEL}#</span><div class="input-area"><div><textarea type="text" id="notation-#{ITEM_ID}#" maxlength="#{MAX_LENGTH}#" rows="7" style="border:none;width:100%;">#{NOTATION_CONTENT}#</textarea><input type="hidden" name="origin" value="#{ORIGIN_CONTENT}#" /></div></div></div>', '<div class="clear"></div>', "</div>"),
            auditTrailWrap: "".concat('<div class="audit-trail">', '<div class="left f11 fwb">#{TITLE}#</div>', '<div class="right"><a href="#" onclick="return false;" class="_audit-trail-closer"><img src="/resources/image/close.png" alt="close"/></a></div>', '<table border="0" width="100%" cellpadding="0" cellspacing="0" class="at-table01">', "#{HEADER}#", "<tbody>#{DATA_ROWS}#</tbody>", "</table>", "</div>"),
            dataAuditTrailHeader: "".concat('<colgroup><col width="4%" /><col width="18%" /><col width="18%" /><col width="21%" /><col width="21%" /><col width="20%" /></colgroup>', "<thead><tr><th>#{NO}#</th><th>#{DATETIME}#</th><th>#{USER}#</th><th>#{ITEM}#</th><th>#{AFTER}#</th><th>#{REASON}#</th></tr></thead>"),
            dataAuditTrailSmallHeader: "".concat('<colgroup><col width="5%" /><col width="22%" /><col width="24%" /><col width="30%" /><col width="20%" /></colgroup>', "<thead><tr><th>#{NO}#</th><th>#{DATETIME}#</th><th>#{USER}#</th><th>#{AFTER}#</th><th>#{REASON}#</th></tr></thead>"),
            dataAuditTrailRow: "<tr><td>#{NO}#</td><td>#{DATETIME}#</td><td>#{USER}#</td><td>#{ITEM}#</td><td>#{AFTER}#</td><td>#{REASON}#</td></tr>",
            dataAuditTrailRowWithNotation: '<tr><td rowspan="2">#{NO}#</td><td rowspan="2">#{DATETIME}#</td><td rowspan="2">#{USER}#</td><td rowspan="2">#{ITEM}#</td><td>#{AFTER}#</td><td rowspan="2">#{REASON}#</td></tr><tr><td style="border-top-style:dashed;">#{AFTER_NOTATION}#</td></tr>',
            dataAuditTrailSmallRow: "<tr><td>#{NO}#</td><td>#{DATETIME}#</td><td>#{USER}#</td><td>#{AFTER}##{AFTER_NOTATION}#</td><td>#{REASON}#</td></tr>",
            dataAuditTrailSmallRowWithNotation: '<tr><td rowspan="2">#{NO}#</td><td rowspan="2">#{DATETIME}#</td><td rowspan="2">#{USER}#</td><td>#{AFTER}#</td><td rowspan="2">#{REASON}#</td></tr><tr><td style="border-top-style:dashed;">#{AFTER_NOTATION}#</td></tr>',
            auditTrailNoData: '<tr><td colspan="#{COL_SPAN}#">#{LABEL}#</td></tr>',
            editReasonContent: "".concat("<div>", '<table cellpadding="0" cellspacing="0" border="0" width="100%" class="layer-table1">', '<colgroup><col width="30%"><col width="70%"></colgroup>', '<tbody><tr><th>#{LABEL}#</th><td><textarea name="entry-edit-reason" rows="2" style="width:100%;">#{DEFAULT}#</textarea></td></tr></tbody>', "</table>", "</div>")
        },
        replace: function(E, D) {
            return E.replace(/#\{([A-Z0-9_]+)\}#/gi, function() {
                var F = arguments[1];
                if (D[F] !== undefined) {
                    if (e.isArray(D[F])) {
                        return D[F].join("")
                    }
                    return D[F]
                }
                return ""
            })
        }
    };
    var v = (function() {
        var E = function() {
            this.instances = {
                product: {
                    query: [{
                        condition: {
                            type: "AND",
                            child: [{
                                type: "EQ",
                                child: [{
                                    type: "ITEM",
                                    selector: "#PRD_MNFT"
                                }, {
                                    type: "VALUE",
                                    value: ""
                                }]
                            }, {
                                type: "EQ",
                                child: [{
                                    type: "ITEM",
                                    selector: "#PRD_MNFT_NA"
                                }, {
                                    type: "VALUE",
                                    value: ""
                                }]
                            }]
                        },
                        message: "required.manufacturer",
                        target: "#PRD_MNFT"
                    }, {
                        condition: {
                            type: "AND",
                            child: [{
                                type: "EQ",
                                child: [{
                                    type: "ITEM",
                                    selector: "#MD_CODE_01"
                                }, {
                                    type: "VALUE",
                                    value: ""
                                }]
                            }, {
                                type: "EQ",
                                child: [{
                                    type: "ITEM",
                                    selector: "#MD_NAME"
                                }, {
                                    type: "VALUE",
                                    value: ""
                                }]
                            }]
                        },
                        message: "required.productIdentity",
                        target: "#MD_CODE_01,#MD_NAME"
                    }],
                    blind: [{
                        condition: {
                            type: "EQ",
                            child: [{
                                type: "ITEM",
                                selector: "#MD_CODE_01"
                            }, {
                                type: "VALUE",
                                value: ""
                            }]
                        },
                        target: "#MD_CODE_02"
                    }, {
                        condition: {
                            type: "EQ",
                            child: [{
                                type: "ITEM",
                                selector: "#MD_CODE_02"
                            }, {
                                type: "VALUE",
                                value: ""
                            }]
                        },
                        target: "#MD_CODE_03"
                    }, {
                        condition: {
                            type: "EQ",
                            child: [{
                                type: "ITEM",
                                selector: "#MD_NAME"
                            }, {
                                type: "VALUE",
                                value: ""
                            }]
                        },
                        target: "#MI_NAME_01"
                    }, {
                        condition: {
                            type: "EQ",
                            child: [{
                                type: "ITEM",
                                selector: "#MI_NAME_01"
                            }, {
                                type: "VALUE",
                                value: ""
                            }]
                        },
                        target: "#MI_NAME_02"
                    }, {
                        condition: {
                            type: "EQ",
                            child: [{
                                type: "ITEM",
                                selector: "#MI_NAME_02"
                            }, {
                                type: "VALUE",
                                value: ""
                            }]
                        },
                        target: "#MI_NAME_03"
                    }]
                },
                protocol: {
                    blind: [{
                        condition: {
                            type: "NOT",
                            child: [{
                                type: "EQ",
                                child: [{
                                    type: "ITEM",
                                    selector: "#PROT_TYPE"
                                }, {
                                    type: "VALUE",
                                    value: "30"
                                }]
                            }]
                        },
                        target: "#PROT_SUB_TYPE"
                    }, {
                        condition: {
                            type: "NOT",
                            child: [{
                                type: "EQ",
                                child: [{
                                    type: "ITEM",
                                    selector: "#PROT_TYPE"
                                }, {
                                    type: "VALUE",
                                    value: "50"
                                }]
                            }]
                        },
                        target: "#PROT_TYPE_ETC"
                    }, {
                        condition: {
                            type: "NOT",
                            child: [{
                                type: "EQ",
                                child: [{
                                    type: "ITEM",
                                    selector: "#IS_MFDS"
                                }, {
                                    type: "VALUE",
                                    value: "1"
                                }]
                            }]
                        },
                        target: "#IS_MFDS_DATE"
                    }, {
                        condition: {
                            type: "NOT",
                            child: [{
                                type: "EQ",
                                child: [{
                                    type: "ITEM",
                                    selector: "#IS_REFER_MD"
                                }, {
                                    type: "VALUE",
                                    value: "1"
                                }]
                            }]
                        },
                        target: "#IS_REFER_SPO,#IS_REFER_NAME"
                    }, {
                        condition: {
                            type: "NOT",
                            child: [{
                                type: "EQ",
                                child: [{
                                    type: "ITEM",
                                    selector: "#IS_REFER_REPORT"
                                }, {
                                    type: "VALUE",
                                    value: "1"
                                }]
                            }]
                        },
                        target: "#IS_REFER_DATE"
                    }]
                },
                sptn_report: {
                    query: [{
                        condition: {
                            type: "AND",
                            child: [{
                                type: "EQ",
                                child: [{
                                    type: "ITEM",
                                    selector: "#SUBJ_AGE"
                                }, {
                                    type: "VALUE",
                                    value: ""
                                }]
                            }, {
                                type: "EQ",
                                child: [{
                                    type: "ITEM",
                                    selector: "#SUBJ_AGE_TYPE"
                                }, {
                                    type: "VALUE",
                                    value: ""
                                }]
                            }, {
                                type: "ANY",
                                child: [{
                                    type: "EQ",
                                    child: [{
                                        type: "ITEM",
                                        selector: "#SUBJ_AGE_OTHER"
                                    }, {
                                        type: "VALUE",
                                        value: ""
                                    }]
                                }, {
                                    type: "EQ",
                                    child: [{
                                        type: "ITEM",
                                        selector: "#SUBJ_AGE_OTHER_UNIT"
                                    }, {
                                        type: "VALUE",
                                        value: ""
                                    }]
                                }]
                            }]
                        },
                        message: "required.spontaneous_age",
                        target: "#SUBJ_AGE,#SUBJ_AGE_TYPE,#SUBJ_AGE_OTHER,#SUBJ_AGE_OTHER_UNIT"
                    }],
                    blind: [{
                        condition: {
                            type: "ANY",
                            child: [{
                                type: "NOT",
                                child: [{
                                    type: "EQ",
                                    child: [{
                                        type: "ITEM",
                                        selector: "#SUBJ_AGE_TYPE"
                                    }, {
                                        type: "VALUE",
                                        value: ""
                                    }]
                                }]
                            }, {
                                type: "NOT",
                                child: [{
                                    type: "EQ",
                                    child: [{
                                        type: "ITEM",
                                        selector: "#SUBJ_AGE_OTHER"
                                    }, {
                                        type: "VALUE",
                                        value: ""
                                    }]
                                }]
                            }, {
                                type: "NOT",
                                child: [{
                                    type: "EQ",
                                    child: [{
                                        type: "ITEM",
                                        selector: "#SUBJ_AGE_OTHER_UNIT"
                                    }, {
                                        type: "VALUE",
                                        value: ""
                                    }]
                                }]
                            }]
                        },
                        target: "#SUBJ_AGE"
                    }, {
                        condition: {
                            type: "ANY",
                            child: [{
                                type: "NOT",
                                child: [{
                                    type: "EQ",
                                    child: [{
                                        type: "ITEM",
                                        selector: "#SUBJ_AGE"
                                    }, {
                                        type: "VALUE",
                                        value: ""
                                    }]
                                }]
                            }, {
                                type: "NOT",
                                child: [{
                                    type: "EQ",
                                    child: [{
                                        type: "ITEM",
                                        selector: "#SUBJ_AGE_OTHER"
                                    }, {
                                        type: "VALUE",
                                        value: ""
                                    }]
                                }]
                            }, {
                                type: "NOT",
                                child: [{
                                    type: "EQ",
                                    child: [{
                                        type: "ITEM",
                                        selector: "#SUBJ_AGE_OTHER_UNIT"
                                    }, {
                                        type: "VALUE",
                                        value: ""
                                    }]
                                }]
                            }]
                        },
                        target: "#SUBJ_AGE_TYPE"
                    }, {
                        condition: {
                            type: "ANY",
                            child: [{
                                type: "NOT",
                                child: [{
                                    type: "EQ",
                                    child: [{
                                        type: "ITEM",
                                        selector: "#SUBJ_AGE"
                                    }, {
                                        type: "VALUE",
                                        value: ""
                                    }]
                                }]
                            }, {
                                type: "NOT",
                                child: [{
                                    type: "EQ",
                                    child: [{
                                        type: "ITEM",
                                        selector: "#SUBJ_AGE_TYPE"
                                    }, {
                                        type: "VALUE",
                                        value: ""
                                    }]
                                }]
                            }]
                        },
                        target: "#SUBJ_AGE_OTHER,#SUBJ_AGE_OTHER_UNIT"
                    }]
                },
                reporter: {
                    blind: [{
                        condition: {
                            type: "NOT",
                            child: [{
                                type: "EQ",
                                child: [{
                                    type: "ITEM",
                                    selector: "#RPT_TYPE"
                                }, {
                                    type: "VALUE",
                                    value: "8"
                                }]
                            }]
                        },
                        target: "#RPT_TYPE_ETC"
                    }]
                },
                "case-BASE_INFO": {
                    query: [{
                        condition: {
                            type: "AND",
                            child: [{
                                type: "NOT",
                                child: [{
                                    type: "EQ",
                                    child: [{
                                        type: "ITEM",
                                        selector: "#case-sourceType"
                                    }, {
                                        type: "VALUE",
                                        value: "spontaneous"
                                    }]
                                }]
                            }, {
                                type: "EQ",
                                child: [{
                                    type: "ITEM",
                                    selector: "#SUBJ_CODE"
                                }, {
                                    type: "VALUE",
                                    value: ""
                                }]
                            }]
                        },
                        message: "mandatoryItem",
                        target: "#SUBJ_CODE"
                    }],
                    blind: [{
                        condition: {
                            type: "EQ",
                            child: [{
                                type: "ITEM",
                                selector: "#case-sourceType"
                            }, {
                                type: "VALUE",
                                value: "spontaneous"
                            }]
                        },
                        target: "#SUBJ_INIT,#SUBJ_SEX",
                        blindOnly: true
                    }, {
                        condition: {
                            type: "NOT",
                            child: [{
                                type: "EQ",
                                child: [{
                                    type: "ITEM",
                                    selector: "#SUBJ_SEX"
                                }, {
                                    type: "VALUE",
                                    value: "2"
                                }]
                            }]
                        },
                        target: "#IS_PREG"
                    }, {
                        condition: {
                            type: "NOT",
                            child: [{
                                type: "EQ",
                                child: [{
                                    type: "ITEM",
                                    selector: "#IS_PREG"
                                }, {
                                    type: "VALUE",
                                    value: "1"
                                }]
                            }]
                        },
                        target: "#IS_PREG_WEEKS,#IS_PREG_WEEKS_UNIT,#IS_PREG_LAST_DATE"
                    }, {
                        condition: {
                            type: "NOT",
                            child: [{
                                type: "EQ",
                                child: [{
                                    type: "ITEM",
                                    selector: "#CARE_TYPE"
                                }, {
                                    type: "VALUE",
                                    value: "3"
                                }]
                            }]
                        },
                        target: "#CARE_TYPE_ETC"
                    }, {
                        condition: {
                            type: "ANY",
                            child: [{
                                type: "EQ",
                                child: [{
                                    type: "ITEM",
                                    selector: "#case-sourceType"
                                }, {
                                    type: "VALUE",
                                    value: "spontaneous"
                                }]
                            }, {
                                type: "NOT",
                                child: [{
                                    type: "EQ",
                                    child: [{
                                        type: "ITEM",
                                        selector: "#AGE_TYPE"
                                    }, {
                                        type: "VALUE",
                                        value: ""
                                    }]
                                }]
                            }, {
                                type: "NOT",
                                child: [{
                                    type: "EQ",
                                    child: [{
                                        type: "ITEM",
                                        selector: "#OTHER_AGE"
                                    }, {
                                        type: "VALUE",
                                        value: ""
                                    }]
                                }]
                            }, {
                                type: "NOT",
                                child: [{
                                    type: "EQ",
                                    child: [{
                                        type: "ITEM",
                                        selector: "#OTHER_AGE_UNIT"
                                    }, {
                                        type: "VALUE",
                                        value: ""
                                    }]
                                }]
                            }]
                        },
                        target: "#AGE",
                        blindOnly: function() {
                            return document.getElementById("case-sourceType").value == "spontaneous"
                        }
                    }, {
                        condition: {
                            type: "ANY",
                            child: [{
                                type: "EQ",
                                child: [{
                                    type: "ITEM",
                                    selector: "#case-sourceType"
                                }, {
                                    type: "VALUE",
                                    value: "spontaneous"
                                }]
                            }, {
                                type: "NOT",
                                child: [{
                                    type: "EQ",
                                    child: [{
                                        type: "ITEM",
                                        selector: "#AGE"
                                    }, {
                                        type: "VALUE",
                                        value: ""
                                    }]
                                }]
                            }, {
                                type: "NOT",
                                child: [{
                                    type: "EQ",
                                    child: [{
                                        type: "ITEM",
                                        selector: "#OTHER_AGE"
                                    }, {
                                        type: "VALUE",
                                        value: ""
                                    }]
                                }]
                            }, {
                                type: "NOT",
                                child: [{
                                    type: "EQ",
                                    child: [{
                                        type: "ITEM",
                                        selector: "#OTHER_AGE_UNIT"
                                    }, {
                                        type: "VALUE",
                                        value: ""
                                    }]
                                }]
                            }]
                        },
                        target: "#AGE_TYPE",
                        blindOnly: function() {
                            return document.getElementById("case-sourceType").value == "spontaneous"
                        }
                    }, {
                        condition: {
                            type: "ANY",
                            child: [{
                                type: "EQ",
                                child: [{
                                    type: "ITEM",
                                    selector: "#case-sourceType"
                                }, {
                                    type: "VALUE",
                                    value: "spontaneous"
                                }]
                            }, {
                                type: "NOT",
                                child: [{
                                    type: "EQ",
                                    child: [{
                                        type: "ITEM",
                                        selector: "#AGE"
                                    }, {
                                        type: "VALUE",
                                        value: ""
                                    }]
                                }]
                            }, {
                                type: "NOT",
                                child: [{
                                    type: "EQ",
                                    child: [{
                                        type: "ITEM",
                                        selector: "#AGE_TYPE"
                                    }, {
                                        type: "VALUE",
                                        value: ""
                                    }]
                                }]
                            }]
                        },
                        target: "#OTHER_AGE,#OTHER_AGE_UNIT",
                        blindOnly: function() {
                            return document.getElementById("case-sourceType").value == "spontaneous"
                        }
                    }, {
                        condition: {
                            type: "NOT",
                            child: [{
                                type: "ANY",
                                child: [{
                                    type: "LT",
                                    child: [{
                                        type: "ITEM",
                                        selector: "#AGE"
                                    }, {
                                        type: "VALUE",
                                        value: "2"
                                    }]
                                }, {
                                    type: "OR",
                                    child: [{
                                        type: "EQ",
                                        child: [{
                                            type: "ITEM",
                                            selector: "#AGE_TYPE"
                                        }, {
                                            type: "VALUE",
                                            value: "1"
                                        }]
                                    }, {
                                        type: "EQ",
                                        child: [{
                                            type: "ITEM",
                                            selector: "#AGE_TYPE"
                                        }, {
                                            type: "VALUE",
                                            value: "2"
                                        }]
                                    }]
                                }, {
                                    type: "AND",
                                    child: [{
                                        type: "NOT",
                                        child: [{
                                            type: "EQ",
                                            child: [{
                                                type: "ITEM",
                                                selector: "#OTHER_AGE"
                                            }, {
                                                type: "VALUE",
                                                value: ""
                                            }]
                                        }]
                                    }, {
                                        type: "ANY",
                                        child: [{
                                            type: "AND",
                                            child: [{
                                                type: "EQ",
                                                child: [{
                                                    type: "ITEM",
                                                    selector: "#OTHER_AGE_UNIT"
                                                }, {
                                                    type: "VALUE",
                                                    value: "4"
                                                }]
                                            }, {
                                                type: "LT",
                                                child: [{
                                                    type: "ITEM",
                                                    selector: "#OTHER_AGE"
                                                }, {
                                                    type: "VALUE",
                                                    value: "730"
                                                }]
                                            }]
                                        }, {
                                            type: "AND",
                                            child: [{
                                                type: "EQ",
                                                child: [{
                                                    type: "ITEM",
                                                    selector: "#OTHER_AGE_UNIT"
                                                }, {
                                                    type: "VALUE",
                                                    value: "2"
                                                }]
                                            }, {
                                                type: "LT",
                                                child: [{
                                                    type: "ITEM",
                                                    selector: "#OTHER_AGE"
                                                }, {
                                                    type: "VALUE",
                                                    value: "24"
                                                }]
                                            }]
                                        }]
                                    }]
                                }]
                            }]
                        },
                        target: "#PARENT_NAME,#PARENT_PREG_WEEKS,#PARENT_SEX,#PARENT_AGE",
                        blindOnly: function() {
                            return document.getElementById("case-sourceType").value == "spontaneous"
                        }
                    }]
                },
                "case-MH": {
                    blind: [{
                        condition: {
                            type: "EQ",
                            child: [{
                                type: "ITEM",
                                selector: "#MH_KCD_VER"
                            }, {
                                type: "VALUE",
                                value: ""
                            }]
                        },
                        target: "#MH_KCD_TERM,#MH_KCD_CODE"
                    }, {
                        condition: {
                            type: "EQ",
                            child: [{
                                type: "ITEM",
                                selector: "#MH_MEDDRA_VER"
                            }, {
                                type: "VALUE",
                                value: ""
                            }]
                        },
                        target: "#MH_MEDDRA_TERM,#MH_MEDDRA_LLT"
                    }, {
                        condition: {
                            type: "NOT",
                            child: [{
                                type: "EQ",
                                child: [{
                                    type: "ITEM",
                                    selector: "#MH_IS_ING"
                                }, {
                                    type: "VALUE",
                                    value: "N"
                                }]
                            }]
                        },
                        target: "#MH_END_DATE"
                    }]
                },
                "case-DH": {
                    blind: [{
                        condition: {
                            type: "EQ",
                            child: [{
                                type: "ITEM",
                                selector: "#DH_ATC_VER"
                            }, {
                                type: "VALUE",
                                value: ""
                            }]
                        },
                        target: "#DH_ATC_TERM,#DH_ATC_CODE_5"
                    }, {
                        condition: {
                            type: "EQ",
                            child: [{
                                type: "ITEM",
                                selector: "#DH_WHOART_VER"
                            }, {
                                type: "VALUE",
                                value: ""
                            }]
                        },
                        target: "#DH_WHOART_TERM,#DH_WHOART_ARRN"
                    }, {
                        condition: {
                            type: "EQ",
                            child: [{
                                type: "ITEM",
                                selector: "#DH_MEDDRA_VER"
                            }, {
                                type: "VALUE",
                                value: ""
                            }]
                        },
                        target: "#DH_MEDDRA_TERM,#DH_MEDDRA_LLT"
                    }, {
                        condition: {
                            type: "EQ",
                            child: [{
                                type: "ITEM",
                                selector: "#DH_IN_MEDDRA_VER"
                            }, {
                                type: "VALUE",
                                value: ""
                            }]
                        },
                        target: "#DH_IN_MEDDRA_TERM,#DH_IN_MEDDRA_LLT"
                    }]
                },
                "case-AE": {
                    blind: [{
                        condition: {
                            type: "EQ",
                            child: [{
                                type: "ITEM",
                                selector: "#AE_WHOART_VER"
                            }, {
                                type: "VALUE",
                                value: ""
                            }]
                        },
                        target: "#AE_WHOART_TERM,#AE_WHOART_ARRN"
                    }, {
                        condition: {
                            type: "EQ",
                            child: [{
                                type: "ITEM",
                                selector: "#AE_MEDDRA_VER"
                            }, {
                                type: "VALUE",
                                value: ""
                            }]
                        },
                        target: "#AE_MEDDRA_TERM,#AE_MEDDRA_LLT"
                    }, {
                        condition: {
                            type: "NOT",
                            child: [{
                                type: "ANY",
                                child: [{
                                    type: "EQ",
                                    child: [{
                                        type: "ITEM",
                                        selector: "#AE_RESULT"
                                    }, {
                                        type: "VALUE",
                                        value: "1"
                                    }]
                                }, {
                                    type: "EQ",
                                    child: [{
                                        type: "ITEM",
                                        selector: "#AE_RESULT"
                                    }, {
                                        type: "VALUE",
                                        value: "6"
                                    }]
                                }, {
                                    type: "EQ",
                                    child: [{
                                        type: "ITEM",
                                        selector: "#AE_RESULT"
                                    }, {
                                        type: "VALUE",
                                        value: "7"
                                    }]
                                }]
                            }]
                        },
                        target: "#AE_END_DATE,#AE_END_TIME"
                    }, {
                        condition: {
                            type: "NOT",
                            child: [{
                                type: "EQ",
                                child: [{
                                    type: "ITEM",
                                    selector: "#AE_SERIOUS"
                                }, {
                                    type: "VALUE",
                                    value: "1"
                                }]
                            }]
                        },
                        target: "#AE_SERIOUS_01,#AE_SERIOUS_02,#AE_SERIOUS_03,#AE_SERIOUS_04,#AE_SERIOUS_05,#AE_SERIOUS_06"
                    }, {
                        condition: {
                            type: "NOT",
                            child: [{
                                type: "EQ",
                                child: [{
                                    type: "ITEM",
                                    selector: "#IS_MFDS_REPORT"
                                }, {
                                    type: "VALUE",
                                    value: "1"
                                }]
                            }]
                        },
                        target: "#IS_MFDS_REPORT_DATE,#IS_MFDS_DUE"
                    }, {
                        condition: {
                            type: "NOT",
                            child: [{
                                type: "EQ",
                                child: [{
                                    type: "ITEM",
                                    selector: "#IS_KIDS_REPORT"
                                }, {
                                    type: "VALUE",
                                    value: "1"
                                }]
                            }]
                        },
                        target: "#IS_KIDS_REPORT_DATE,#IS_KIDS_DUE"
                    }, {
                        condition: {
                            type: "NOT",
                            child: [{
                                type: "EQ",
                                child: [{
                                    type: "ITEM",
                                    selector: "#IS_IRB_REPORT"
                                }, {
                                    type: "VALUE",
                                    value: "1"
                                }]
                            }]
                        },
                        target: "#IS_IRB_DUE,#IS_IRB_REPORT_DATE"
                    }, {
                        condition: {
                            type: "NOT",
                            child: [{
                                type: "EQ",
                                child: [{
                                    type: "ITEM",
                                    selector: "#IS_OTHER_REPORT"
                                }, {
                                    type: "VALUE",
                                    value: "1"
                                }]
                            }]
                        },
                        target: "#IS_OTHER_DUE,#IS_OTHER_REPORT_DATE"
                    }, {
                        condition: {
                            type: "EQ",
                            child: [{
                                type: "ITEM",
                                selector: "#AE_DEATH_DATE"
                            }, {
                                type: "VALUE",
                                value: ""
                            }]
                        },
                        target: "#AE_DEATH_KCD_VER,#AE_DEATH_CAUSE,#AE_AUTOPSY,#AE_DETAIL_INFO"
                    }, {
                        condition: {
                            type: "NOT",
                            child: [{
                                type: "EQ",
                                child: [{
                                    type: "ITEM",
                                    selector: "#AE_AUTOPSY"
                                }, {
                                    type: "VALUE",
                                    value: "1"
                                }]
                            }]
                        },
                        target: "#AUTOPSY_KCD_VER,#AE_AUTOPSY_CAUSE"
                    }, {
                        condition: {
                            type: "EQ",
                            child: [{
                                type: "ITEM",
                                selector: "#AE_DEATH_KCD_VER"
                            }, {
                                type: "VALUE",
                                value: ""
                            }]
                        },
                        target: "#AE_DEATH_KCD_TERM,#AE_DEATH_KCD_CODE"
                    }, {
                        condition: {
                            type: "EQ",
                            child: [{
                                type: "ITEM",
                                selector: "#AUTOPSY_KCD_VER"
                            }, {
                                type: "VALUE",
                                value: ""
                            }]
                        },
                        target: "#AUTOPSY_KCD_TERM,#AUTOPSY_KCD_CODE"
                    }, {
                        condition: {
                            type: "NOT",
                            child: [{
                                type: "EQ",
                                child: [{
                                    type: "ITEM",
                                    selector: "#IS_MNFT_REPORT"
                                }, {
                                    type: "VALUE",
                                    value: "1"
                                }]
                            }]
                        },
                        target: "#IS_MNFT_REPORT_DATE"
                    }]
                },
                "case-CM": {
                    blind: [{
                        condition: {
                            type: "EQ",
                            child: [{
                                type: "ITEM",
                                selector: "#CM_ATC_VER"
                            }, {
                                type: "VALUE",
                                value: ""
                            }]
                        },
                        target: "#CM_ATC_TERM,#CM_ATC_CODE_5"
                    }, {
                        condition: {
                            type: "EQ",
                            child: [{
                                type: "ITEM",
                                selector: "#CM_KCD_VER"
                            }, {
                                type: "VALUE",
                                value: ""
                            }]
                        },
                        target: "#CM_KCD_TERM,#CM_KCD_CODE"
                    }, {
                        condition: {
                            type: "EQ",
                            child: [{
                                type: "ITEM",
                                selector: "#CM_MEDDRA_VER"
                            }, {
                                type: "VALUE",
                                value: ""
                            }]
                        },
                        target: "#CM_MEDDRA_TERM,#CM_MEDDRA_LLT"
                    }, {
                        condition: {
                            type: "NOT",
                            child: [{
                                type: "OR",
                                child: [{
                                    type: "EQ",
                                    child: [{
                                        type: "ITEM",
                                        selector: "#CM_ACTION"
                                    }, {
                                        type: "VALUE",
                                        value: "2"
                                    }]
                                }, {
                                    type: "EQ",
                                    child: [{
                                        type: "ITEM",
                                        selector: "#CM_ACTION"
                                    }, {
                                        type: "VALUE",
                                        value: "5"
                                    }]
                                }]
                            }]
                        },
                        target: "#CM_RESULT,#CM_IS_AE"
                    }, {
                        condition: {
                            type: "NOT",
                            child: [{
                                type: "EQ",
                                child: [{
                                    type: "ITEM",
                                    selector: "#CM_ING"
                                }, {
                                    type: "VALUE",
                                    value: "N"
                                }]
                            }]
                        },
                        target: "#CM_END_DATE"
                    }]
                }
            }
        };
        E.prototype.bindTriggerEvent = function(I) {
            if (I === undefined || I.length == 0) {
                return false
            }
            var O = this,
                F = O.instances[I],
                L = e(document.getElementById(I)).find("input,textarea,select").filter(function() {
                    return !/(radio|button|file)/i.test(this.type)
                }),
                G = [];
            var K = function(T) {
                var S;
                if (T.selector) {
                    S = [T.selector]
                }
                if (T.child) {
                    for (var U = 0, Q = T.child.length; U < Q; U++) {
                        var R = K(T.child[U]);
                        if (R === undefined) {
                            continue
                        }
                        if (S === undefined) {
                            S = []
                        }
                        e.merge(S, R)
                    }
                }
                return S
            };
            if (F !== undefined && F.blind !== undefined) {
                for (var M = 0, P = F.blind.length; M < P; M++) {
                    var N = K(F.blind[M]["condition"]);
                    if (N) {
                        G.push(N);
                        F.blind[M]["triggers"] = N
                    }
                }
            }
            if (G.length == 0) {
                return false
            }
            var H = L.filter(G.join(",")),
                J = H.filter('[type="checkbox"]');
            if (J.length > 0) {
                J.on("click", e.proxy(O.eventBaseTest, O));
                H = H.not(J)
            }
            J = H.filter('[data-type="toggleradio"]');
            if (J.length > 0) {
                J.on("change.radiotoggle", e.proxy(O.eventBaseTest, O));
                H = H.not(J)
            }
            J = H.filter("select");
            if (J.length > 0) {
                J.on("change", e.proxy(O.eventBaseTest, O));
                H = H.not(J)
            }
            J = H.filter('[data-datatype="DATE"]');
            if (J.length > 0) {
                J.on("change.datepicker", e.proxy(O.eventBaseTest, O));
                H = H.not(J)
            }
            J = H.filter('input[type="text"],textarea');
            if (J.length > 0) {
                J.on("focusout", e.proxy(O.eventBaseTest, O))
            }
            return true
        };
        E.prototype.nodeFunctions = function(H, J) {
            var N = this,
                L = H && H.child ? H.child.length : 0,
                F, K, G;
            switch (H.type) {
                case "LT":
                    if (L != 2) {
                        return undefined
                    }
                    F = parseFloat(N.nodeFunctions(H.child[0], J));
                    K = parseFloat(N.nodeFunctions(H.child[1], J));
                    if (isNaN(F) || isNaN(K)) {
                        return undefined
                    }
                    G = F < K;
                    break;
                case "EQ":
                    if (L != 2) {
                        return undefined
                    }
                    F = N.nodeFunctions(H.child[0], J);
                    K = N.nodeFunctions(H.child[1], J);
                    G = (F == K || ((F === undefined || F === null || F.length == 0) && (K === undefined || K == null || K.length == 0)));
                    break;
                case "AND":
                    if (L < 2) {
                        return undefined
                    }
                    G = true;
                    for (var I = 0; I < L; I++) {
                        F = N.nodeFunctions(H.child[I], J);
                        if (F === undefined) {
                            G = false;
                            break
                        }
                        G = G && F;
                        if (!G) {
                            break
                        }
                    }
                    break;
                case "ANY":
                    if (L < 2) {
                        return undefined
                    }
                    G = false;
                    for (var I = 0; I < L; I++) {
                        F = N.nodeFunctions(H.child[I], J);
                        if (F === undefined) {
                            continue
                        }
                        G = G || F;
                        if (G) {
                            break
                        }
                    }
                    break;
                case "OR":
                    if (L < 2) {
                        return undefined
                    }
                    G = false;
                    for (var I = 0; I < L; I++) {
                        F = N.nodeFunctions(H.child[I], J);
                        if (F === undefined) {
                            G = undefined;
                            break
                        }
                        G = G || F;
                        if (G) {
                            break
                        }
                    }
                    break;
                case "NOT":
                    if (L != 1) {
                        return undefined
                    }
                    F = N.nodeFunctions(H.child[0], J);
                    if (F === undefined) {
                        return undefined
                    }
                    G = !F;
                    break;
                case "ITEM":
                    if (H.selector === undefined) {
                        return undefined
                    }
                    var M = J.filter(H.selector);
                    if (M.length == 0) {
                        return undefined
                    }
                    if (M.is('[type="checkbox"]')) {
                        if (M.prop("checked")) {
                            G = M.val()
                        }
                    } else {
                        G = M.val()
                    }
                    break;
                case "VALUE":
                    G = H.value;
                    break
            }
            return G
        };
        E.prototype.eventBaseTest = function(J) {
            if (!J) {
                return false
            }
            var H = this,
                I = e(J.target),
                G = I.closest(".case-entry-wrap").prop("id"),
                F = e(document.getElementById(G)).find("input,textarea,select").filter(function() {
                    return !/(radio|button|file)/i.test(this.type)
                });
            H.test(G, I, F);
            return true
        };
        E.prototype.test = function(M, R, J) {
            var O = this,
                G = O.instances[M],
                I, N, H = 0,
                L = [];
            if (G !== undefined && G.blind !== undefined) {
                N = G.blind.length;
                var K = [];
                do {
                    H = L.length;
                    for (I = 0; I < N; I++) {
                        var F = false;
                        for (var P = 0, W = L.length; P < W; P++) {
                            if (L[P] == I) {
                                F = true;
                                break
                            }
                        }
                        if (F) {
                            continue
                        }
                        var S = G.blind[I],
                            X = J.filter(S.target);
                        if (X.length > 0) {
                            var U = O.testAndItemBlind(R, S, X, J);
                            if (U !== undefined && U.actions) {
                                if (U.actions.length > 0) {
                                    e.merge(K, U.actions)
                                }
                                if (U.valueChanged !== undefined) {
                                    L.push(I);
                                    H++;
                                    if (U.valueChanged.length > 0) {
                                        e.merge(R, U.valueChanged)
                                    }
                                }
                            }
                        }
                    }
                } while (H < L.length);
                if (K.length > 0) {
                    for (var V = 0, Q = K.length; V < Q; V++) {
                        var T = K[V];
                        if (T.element) {
                            switch (T.property) {
                                case "disabled":
                                    T.element.disabled = T.value;
                                    break;
                                case "checked":
                                    T.element.checked = T.value;
                                    break
                            }
                        } else {
                            if (T.item) {
                                switch (T.property) {
                                    case "addClass":
                                        T.item.addClass(T.value);
                                        break;
                                    case "removeClass":
                                        T.item.removeClass(T.value);
                                        break;
                                    default:
                                        T.item.prop(T.property, T.value)
                                }
                            }
                        }
                    }
                }
            }
        };
        E.prototype.testAndItemBlind = function(R, S, W, J) {
            if (R.filter(S.triggers.join(",")).length == 0) {
                return undefined
            }
            var P = this,
                U;
            var T = P.nodeFunctions(S.condition, J);
            if (T === undefined) {
                return undefined
            }
            var F = false;
            if (S.blindOnly) {
                if (typeof S.blindOnly == "function") {
                    F = S.blindOnly.call(P)
                } else {
                    if (S.blindOnly === true) {
                        F = S.blindOnly
                    }
                }
            }
            var L = [];
            if (T) {
                U = W.filter(function() {
                    return (/checkbox/i.test(this.type) && this.checked) || this.value.length > 0
                });
                L.push({
                    item: W,
                    property: "disabled",
                    value: true
                });
                L.push({
                    item: W.closest(".item-wrap"),
                    property: "addClass",
                    value: "item-blind"
                });
                var M = W.filter('[data-type="toggleradio"]');
                if (M.length > 0) {
                    for (var Q = 0, O = M.length; Q < O; Q++) {
                        var G = document.getElementsByName(M.eq(Q).prop("name") + "-r");
                        for (var N = 0, I = G.length; N < I; N++) {
                            L.push({
                                element: G[N],
                                property: "disabled",
                                value: true
                            });
                            if (!F) {
                                L.push({
                                    element: G[N],
                                    property: "checked",
                                    value: false
                                })
                            }
                        }
                    }
                }
                if (F) {
                    L.push({
                        item: W,
                        property: "addClass",
                        value: d
                    })
                } else {
                    var V = W.filter('[type="checkbox"]').prop("checked", false);
                    L.push({
                        item: W.not(V),
                        property: "value",
                        value: ""
                    })
                }
            } else {
                var K = W.closest(".item-wrap").filter(".item-blind"),
                    H = K.not(".item-deleted").find(W);
                L.push({
                    item: K,
                    property: "removeClass",
                    value: "item-blind"
                });
                L.push({
                    item: H,
                    property: "disabled",
                    value: false
                });
                var M = H.filter('[data-type="toggleradio"]');
                if (M.length > 0) {
                    for (var Q = 0, O = M.length; Q < O; Q++) {
                        var G = document.getElementsByName(M.eq(Q).prop("name") + "-r");
                        for (var N = 0, I = G.length; N < I; N++) {
                            L.push({
                                element: G[N],
                                property: "disabled",
                                value: false
                            })
                        }
                    }
                }
            }
            return {
                valueChanged: U,
                actions: L
            }
        };
        E.prototype.reset = function(H) {
            if (H.length == 0) {
                return false
            }
            var G = this,
                I = e(document.getElementById(H)).find("input,textarea,select").filter(function() {
                    return !/input/i.test(this.tagName) || !/(radio|button|file)/i.test(this.type)
                }),
                F = I;
            F.filter('[type="checkbox"]').each(function(R, Q) {
                if (/(NA|ND)$/i.test(Q.name)) {
                    var P = /^([A-Z0-9_]+)_(NA|ND)$/.exec(Q.name);
                    if (P[1] !== undefined) {
                        var K = document.getElementsByName(P[1]);
                        for (var N = 0, S = K.length; N < S; N++) {
                            var O = K[N];
                            if (Q.checked) {
                                O.disabled = true;
                                if (/(checkbox|radio)/i.test(O.type)) {
                                    O.checked = false
                                } else {
                                    if (/select/i.test(O.tagName)) {
                                        O.selectedIndex = -1
                                    } else {
                                        if (e(O).is('[data-type="toggleradio"]')) {
                                            O.value = "";
                                            var L = document.getElementsByName(O.name + "-r");
                                            for (var J = 0, M = L.length; J < M; J++) {
                                                L[J].checked = false
                                            }
                                        } else {
                                            O.value = ""
                                        }
                                    }
                                }
                            } else {
                                O.disabled = false
                            }
                        }
                    }
                }
            });
            G.test(H, I, F)
        };
        E.prototype.manualTest = function(I) {
            var H = this,
                G = I.closest(".case-entry-wrap").prop("id");
            if (!G || G.length == 0) {
                return false
            }
            var F = e(document.getElementById(G)).find("input,textarea,select").filter(function() {
                return !/(radio|button|file)/i.test(this.type)
            });
            H.test(G, I, F)
        };
        E.prototype.query = function(J, L) {
            if (J.length == 0) {
                return false
            }
            var T = this,
                M = e(document.getElementById(J)).find("input,textarea,select").filter(function() {
                    return !/(radio|button|file)/i.test(this.type)
                }),
                F = T.instances[J],
                S = true;
            if (F && F.query) {
                for (var G = 0, N = F.query.length; G < N; G++) {
                    var Q = F.query[G];
                    var P = T.nodeFunctions(Q.condition, M);
                    if (P) {
                        S = false;
                        var V = M.filter(Q.target),
                            H = '<div class="item-mandatory"><div>' + L[Q.message] + "</div></div>";
                        if (V.length > 0) {
                            var U = V.closest(".item-row-wrap"),
                                R = 0,
                                I = U.length;
                            for (; R < I; R++) {
                                var K = U.eq(R),
                                    O = K.next();
                                if (O.is("." + a)) {
                                    O.prepend(H)
                                } else {
                                    K.after('<div class="screen-visible ' + a + '">' + H + "</div>")
                                }
                            }
                            U = V.closest(".item-group");
                            for (R = 0, I = U.length; R < I; R++) {
                                var K = U.eq(R).parent(),
                                    O = K.next();
                                if (O.is("." + a)) {
                                    O.prepend(H)
                                } else {
                                    K.after('<div class="screen-hidden ' + a + '">' + H + "</div>")
                                }
                            }
                            V.closest(".item-wrap").prev().find(".item-label > div").addClass("label-warning")
                        }
                    }
                }
            }
            return S
        };
        var D = new E();
        return {
            bindTriggerEvent: function(F) {
                D.bindTriggerEvent.call(D, F)
            },
            reset: function(F) {
                D.reset.call(D, F)
            },
            manual: function(F) {
                D.manualTest(F)
            },
            query: function(F, G) {
                return D.query.call(D, F, G)
            }
        }
    })();
    e(window).load(function() {
        if (!document.getElementById("log-in-wrap")) {
            var H = {
                element: undefined,
                minute: 0,
                startTime: 0,
                timeoutHandler: undefined
            };
            var E = false;
            var D = document.getElementById("expire-timer");
            if (D) {
                H.element = e(D);
                var G = H.element.text().split(":");
                H.minute = (parseInt(G[0], 10) * 60) + parseInt(G[1], 10)
            } else {
                H.minute = 30 * 60
            }
            H.startTime = new Date().getTime();
            H.timeoutHandler = function() {
                var I = new Date().getTime(),
                    J = Math.ceil((I - H.startTime) / 1000),
                    R = H.minute - J;
                if (R < 1) {
                    e(document).unbind("ajaxError");
                    var P = document.getElementById("link-logout");
                    var O;
                    if (P) {
                        O = P.href
                    }
                    if (!O) {
                        O = "/logout"
                    }
                    if (/\?/.test(O)) {
                        O += "&"
                    } else {
                        O += "?"
                    }
                    O += "timeout=expire";
                    location.href = O
                } else {
                    if (R % (4 * 60) == 0) {
                        if (document.getElementById("btn_user_option")) {
                            e.ajax({
                                type: "POST",
                                url: "/loginkeepalive",
                                data: {
                                    time: R
                                },
                                hideLoading: true,
                                skipErrorHandler: true
                            })
                        }
                    }
                }
                if (!E && R < 10) {
                    E = true;
                    var M = "".concat('<div class="alert-box-wrap">', '<div class="alert-box">', '<div><img src="/resources/image/clock.png" alt="" /></div>', '<div class="pt5">', (q.LOGOUT_NOTICE || "After <span>10 seconds</span> you will be <span>logged out</span> automatically."), "</div>", '<div class="pt20"><a href="#" class="alert-btn1">', (q["LOGOUT_EXPIRE.EXTEND"] || "Extend"), '</a> <a href="#" class="alert-btn2">', (q["LOGOUT_EXPIRE.IGNORE"] || "Ignore"), "</a></div></div></div>");
                    var N = e(M);
                    var Q = document.getElementById("wrap");
                    if (Q) {
                        e(Q).append(N)
                    } else {
                        e(document.body).append(N)
                    }
                    N.on("click", ".alert-btn1", function() {
                        H.startTime = new Date().getTime();
                        N.remove();
                        E = false
                    });
                    N.on("click", ".alert-btn2", function() {
                        N.remove()
                    })
                }
                if (H.element && H.element.length > 0) {
                    var L = Math.floor(R / 60),
                        K = R % 60;
                    R = (L < 10 ? "0" : "") + L + ":" + (K < 10 ? "0" : "") + K;
                    H.element.text(R)
                }
            };
            setInterval(H.timeoutHandler, 1000)
        }
        var F = [];
        e(document).on("ajaxSend ajaxError ajaxComplete", function(L, M, K) {
            switch (L.type) {
                case "ajaxSend":
                    if (K.url != "/loginkeepalive") {
                        if (H) {
                            H.startTime = new Date().getTime()
                        }
                        if (e("#ajax-loader").length == 0 && !K.hideLoading) {
                            e(document.body).append('<div id="ajax-loader-overlay"></div><div id="ajax-loader"></div>')
                        }
                        F.push(M)
                    }
                    break;
                case "ajaxError":
                    if (K.skipErrorHandler) {
                        return
                    }
                    if (M.status == 500) {
                        var O = M.responseJSON;
                        if (O && O.exception && O.exception.length > 0) {
                            if (O.exception == "LOGIN_REQUIRED") {
                                window.location.href = window.location.pathname
                            } else {
                                alert(O.exception)
                            }
                        } else {
                            alert("요청하신 내용을 처리하는 과정에 오류가 발생하였습니다. 관리자에게 문의하여 주십시오.")
                        }
                    } else {
                        alert("요청하신 내용은 존재하지 않거나 권한이 부족하여 실행할 수 없습니다. 관리자에게 문의하여 주십시오.")
                    }
                    break;
                case "ajaxComplete":
                    var J = e.inArray(M, F);
                    if (J > -1) {
                        F.splice(J, 1)
                    }
                    var N = F.length;
                    if (N == 1 && !K.hideLoading) {
                        N = 0
                    }
                    if (N == 0) {
                        e("#ajax-loader,#ajax-loader-overlay").remove()
                    }
                    var O = M.responseJSON;
                    if (O && O.deleteCookie && O.deleteCookie.length > 0) {
                        var I = new Date();
                        document.cookie = O.deleteCookie + "=" + 1 + ";expires=" + I.toGMTString() + ";path=/"
                    }
                    break
            }
        });
        e(document).on("submit", "form", function() {
            if (/form/i.test(this.tagName) && this.style.display == "none" && this.getElementsByTagName("iframe").length == 1 && /iframe-transport-\d+/.test(this.getElementsByTagName("iframe")[0].name)) {
                return
            }
            e(window).unbind("beforeunload");
            e(document).unbind("ajaxSend").unbind("ajaxComplete").unbind("ajaxError");
            e.each(F, function(I, J) {
                J.abort()
            })
        });
        e(window).bind("beforeunload", function() {
            e(document).unbind("ajaxSend").unbind("ajaxComplete").unbind("ajaxError");
            e.each(F, function(I, J) {
                J.abort()
            })
        })
    });
    e(document.body).on("click", 'input[type="radio"]', function(E) {
        var L = E.target;
        if (!(/-r$/.test(L.name))) {
            return
        }
        var K = L.name.replace(/-r$/, ""),
            G = document.getElementById(K),
            J = e(G).prop("readonly"),
            I;
        if (J) {
            I = G.value
        } else {
            if (L.value == G.value) {
                I = "";
                G.value = ""
            } else {
                G.value = L.value
            }
        }
        if (I !== undefined) {
            var H = document.getElementsByName(this.name);
            for (var F = 0, M = H.length; F < M; F++) {
                if (H[F].value == I) {
                    H[F].checked = true;
                    break
                }
            }
        } else {
            I = L.value
        }
        if (!J) {
            var D = e.Event("change.radiotoggle");
            D.data = [I];
            e(G).trigger(D)
        }
    });
    e(document.body).on("keypress keyup focusout click", 'input[data-datatype="N"]', function(E) {
        var J = e(E.currentTarget),
            G = J.attr("data-fixedlen"),
            H = J.attr("data-floatlen");
        G = !G || /[^0-9]/.test(G) ? 0 : G;
        H = !H || /[^0-9]/.test(H) ? 0 : H;
        if (E.type == "keypress") {
            var K;
            if (!E.which) {
                K = String.fromCharCode(E.keyCode)
            } else {
                if (E.which != 0 && E.charCode != 0) {
                    K = String.fromCharCode(E.which)
                }
            }
            var O = false,
                M = H > 0 ? "[^0-9.]" : "[^0-9]";
            if (K) {
                var N = J.val();
                O = O || new RegExp(M).test(K);
                O = O || (/[^0-9]/.test(K) && N.indexOf(K) > -1);
                if (!O && K != "." && N.indexOf(".") == -1) {
                    var F = false;
                    if (E.target.createTextRange) {
                        var L = document.selection.createRange().duplicate();
                        F = L.text.length > 0
                    } else {
                        F = E.target.selectionEnd - E.target.selectionStart > 0
                    }
                    if (F == false && G - N.length < 1) {
                        O = true
                    }
                }
            }
            if (O) {
                if (document.addEventListener) {
                    E.preventDefault();
                    E.stopPropagation()
                } else {
                    if (document.attachEvent) {
                        E.returnValue = false
                    }
                }
            }
        } else {
            var D = J.val();
            if (H > 0 && D.indexOf(".") > -1) {
                M = "\\d{0," + G + "}\\.\\d{0," + H + "}"
            } else {
                M = "\\d{0," + G + "}"
            }
            if (new RegExp("^" + M + "$").test(D) == false) {
                var I = new RegExp(M).exec(D);
                if (I.length > 0) {
                    J.val(I[0])
                } else {
                    J.val("")
                }
            }
        }
    });
    if (/MSIE/gi.test(navigator.userAgent)) {
        e(document.body).on("keyup", "textarea[maxlength]", function(G) {
            var D = e(G.target),
                F = D.attr("maxlength");
            F = !F || /[^0-9]/.test(F) ? 0 : F;
            if (F > 0) {
                var E = D.val();
                if (E.length > F) {
                    D.val(E.substring(0, F))
                }
            }
        })
    }
    e(document.body).on("keypress keyup focusout click", "#SUBJ_INIT", function(F) {
        var D = e(F.currentTarget),
            E = D.val(),
            G = E.toUpperCase();
        if (E != G) {
            D.val(G)
        }
    });
    e(document.body).on("click", '[type="checkbox"]', function(E) {
        var L = E.currentTarget;
        if (/(NA|ND)$/i.test(L.name)) {
            var K = /^([A-Z0-9_]+)_(NA|ND)$/.exec(L.name);
            if (K[1] !== undefined) {
                var F = document.getElementsByName(K[1]);
                for (var I = 0, M = F.length; I < M; I++) {
                    var J = F[I];
                    if (L.checked) {
                        J.disabled = true;
                        if (/(checkbox|radio)/i.test(J.type)) {
                            J.checked = false
                        } else {
                            if (/select/i.test(J.tagName)) {
                                J.selectedIndex = -1
                            } else {
                                if (e(J).is('[data-type="toggleradio"]')) {
                                    J.value = "";
                                    var G = document.getElementsByName(J.name + "-r");
                                    for (var D = 0, H = G.length; D < H; D++) {
                                        G[D].checked = false
                                    }
                                } else {
                                    J.value = ""
                                }
                            }
                        }
                    } else {
                        J.disabled = false
                    }
                }
            }
        }
    });
    e(document.body).on("click", 'input[type="button"]', function(E) {
        var L = E.currentTarget;
        if (!/btn-active/gi.test(L.className) || !/-(upload|download)$/i.test(L.id)) {
            return false
        }
        var I = L.id.replace(/([A-Z0-9_]+)-(upload|download)$/, "$1");
        if (/-upload$/i.test(L.id)) {} else {
            if (/-download$/i.test(L.id)) {
                var H = document.getElementById(I),
                    J = document.getElementById(I + "_H"),
                    G = ['<input type="hidden" name="filename" value="' + H.value + '" />', '<input type="hidden" name="fileDownloadPath" value="' + J.value + '" />'];
                if (document.getElementById("paging-entry-form-wrap")) {
                    var F = document.getElementById("paging-entry-page").value,
                        D = document.getElementById("paging-entry-key"),
                        K;
                    if (D && D.value.length > 0 && parseInt(D.value, 10) > 0) {
                        K = D.value
                    } else {
                        if (q.initializeContent && q.initializeContent["totalCount"] !== undefined) {
                            K = (q.initializeContent["totalCount"] + 1) + ""
                        } else {
                            K = "1"
                        }
                    }
                    G.push('<input type="hidden" name="page" value="' + F + '" />');
                    G.push('<input type="hidden" name="pageNo" value="' + K + '" />')
                } else {
                    var M = e(".contents-detail form:eq(0)");
                    if (M.length == 0 || !(M[0]["page"])) {
                        return false
                    }
                    G.push('<input type="hidden" name="page" value="' + M[0]["page"].value + '" />');
                    G.push('<input type="hidden" name="pageNo" value="0" />')
                }
                m("/file/download", G)
            }
        }
        return false
    });

//    function y(E) {
//        var F = E.prop("id").replace(/-file$/i, ""),
//            D = E.closest(".case-entry-wrap");
//        E.removeClass(A);
//        E.fileupload({
//            url: "/file/upload.json",
//            dataType: "json",
//            add: function(K, I) {
//                var J = {
//                    fileUploadItemId: F,
//                    page: "0",
//                    pageNo: "0"
//                };
//                if (document.getElementById("paging-entry-form-wrap")) {
//                    J.page = document.getElementById("paging-entry-page").value;
//                    var G = document.getElementById("paging-entry-key");
//                    if (G && G.value.length > 0 && parseInt(G.value, 10) > 0) {
//                        J.pageNo = G.value
//                    } else {
//                        if (q.initializeContent && q.initializeContent["totalCount"] !== undefined) {
//                            J.pageNo = (q.initializeContent["totalCount"] + 1) + ""
//                        } else {
//                            J.pageNo = "1"
//                        }
//                    }
//                } else {
//                    var H = e(".contents-detail form:eq(0)");
//                    if (H.length == 0 || !(H[0]["page"])) {
//                        return
//                    }
//                    J.page = H[0]["page"].value
//                }
//                I.formData = J;
//                if (e._data(D[0]).events != undefined) {
//                    e.each(e._data(D[0]).events, function(L, M) {
//                        if (L == "fileUploadRequest") {
//                            e.each(M, function(N, O) {
//                                if (O.data == F) {
//                                    M.splice(N, 1)
//                                }
//                            })
//                        }
//                    })
//                }
//                I.context = D.bind("fileUploadRequest.entry", F, function() {
//                    D.unbind("fileUploadRequest.entry");
//                    I.submit()
//                });
//                e("#" + F + "-file").addClass(A)
//            },
//            change: function(H, G) {
//                if (G && G.files && G.files.length > 0 && G.files[0]["name"]) {
//                    document.getElementById(F).value = G.files[0]["name"]
//                }
//            },
//            done: function(H, G) {
//                if (F) {
//                    document.getElementById(F).value = G.result.origin;
//                    document.getElementById(F + "_H").value = G.result.saved;
//                    e(document.getElementById(F + "-download")).removeClass("btn-inactive").addClass("btn-active")
//                }
//                D.trigger("uploadComplete.file")
//            }
//        })
//    }
//    (function() {
//        if (document.getElementById("form-login")) {
//            function F() {
//                var I = document.getElementById("login-userId").value,
//                    H = document.getElementById("login-password").value;
//                I = e.trim(I);
//                if (I.length == 0 || H.length == 0) {
//                    alert(q.login["empty.userId.password"] || "Please enter ID or Password.");
//                    return false
//                }
//                document.getElementById("form-login").submit()
//            }
//            e(document.body).on("click", "#btn-login", function() {
//                F();
//                return false
//            });
//            e(document.body).on("keyup", "#login-password", function(H) {
//                if (H.keyCode == 13) {
//                    F()
//                }
//            });
//            e(document.body).on("click", "#btn-login-retry", function() {
//                e("#login-error-cube").css("top", "300px")
//            });
//            e(document.body).on("click", "#btn-login-findid", function() {
//                document.getElementById("findid-username").value = "";
//                document.getElementById("findid-email").value = "";
//                e("#login-findid-cube").css("left", "0")
//            });
//            e(document.body).on("click", "#btn-login-findpw", function() {
//                document.getElementById("findpw-userId").value = "";
//                e("#login-findpw-cube").css("left", "0")
//            });
//            e(document.body).on("click", "#btn-login-reset,#btn-go-login,#btn-go-login2", function() {
//                e("#login-error-cube").css("top", "300px");
//                var H = e("#login-findid-cube").css("left", "-300px").find(".cube");
//                var I = H.last().css("display", "");
//                H.not(I).css("display", "none");
//                H = e("#login-findpw-cube").css("left", "300px").find(".cube");
//                I = H.last().css("display", "");
//                H.not(I).css("display", "none")
//            });
//
//            function G() {
//                var I = document.getElementById("findid-username").value,
//                    H = document.getElementById("findid-email").value;
//                I = e.trim(I);
//                H = e.trim(H);
//                if (I.length == 0 || H.length == 0) {
//                    alert(q.login["empty.findId.info"] || "Please enter Username or Email.");
//                    return
//                }
//                e.ajax({
//                    type: "POST",
//                    url: "/login/find-id.json",
//                    data: {
//                        username: I,
//                        email: H
//                    },
//                    success: function(K) {
//                        if (K.result == "succeed") {
//                            var J = e("#login-findid-cube").find(".cube");
//                            J.eq(0).children().first().html(K.message);
//                            J.eq(0).css("display", "");
//                            J.eq(1).css("display", "none");
//                            document.getElementById("login-userId").value = K.user
//                        } else {
//                            if (K.message) {
//                                var L = e("#login-error-cube");
//                                L.find(".cube > div:eq(0)").html(K.message);
//                                L.css("top", "0");
//                                document.getElementById("login-userId").value = ""
//                            }
//                        }
//                        document.getElementById("login-password").value = ""
//                    },
//                    dataType: "json",
//                    hideLoading: true
//                })
//            }
//            e(document.body).on("click", "#btn-find-id", G);
//            e(document.body).on("keyup", "#findid-email", function(H) {
//                if (H.keyCode == 13) {
//                    G()
//                }
//            });
//            e(document.body).on("click", "#btn-go-findpw", function() {
//                document.getElementById("findpw-userId").value = document.getElementById("login-userId").value;
//                e("#login-findpw-cube").css("left", "0");
//                e("#login-findid-cube").css("left", "-300px")
//            });
//
//            function E() {
//                var H = document.getElementById("findpw-userId").value;
//                H = e.trim(H);
//                if (H.length == 0) {
//                    alert(q.login["empty.findPw.user"] || "Please enter User ID.");
//                    return
//                }
//                e.ajax({
//                    type: "POST",
//                    url: "/login/find-pw.json",
//                    data: {
//                        user: H
//                    },
//                    success: function(J) {
//                        if (J.result == "succeed") {
//                            document.getElementById("findpw-userId2").value = J.userId;
//                            document.getElementById("findpw-qst").value = J.question;
//                            document.getElementById("findpw-ans").value = "";
//                            var I = e("#login-findpw-cube").find(".cube");
//                            I.eq(1).css("display", "");
//                            I.eq(2).css("display", "none")
//                        } else {
//                            if (J.message) {
//                                var K = e("#login-error-cube");
//                                K.find(".cube > div:eq(0)").html(J.message);
//                                K.css("top", "0")
//                            }
//                        }
//                    },
//                    dataType: "json",
//                    hideLoading: true
//                })
//            }
//            e(document.body).on("click", "#btn-find-pw", E);
//            e(document.body).on("keyup", "#findpw-userId", function(H) {
//                if (H.keyCode == 13) {
//                    E()
//                }
//            });
//
//            function D() {
//                var H = document.getElementById("findpw-userId").value,
//                    I = document.getElementById("findpw-ans").value;
//                H = e.trim(H);
//                if (H.length == 0 || I.length == 0) {
//                    alert(q.login["empty.findPw.info"] || "Please enter answer.");
//                    return
//                }
//                e.ajax({
//                    type: "POST",
//                    url: "/login/find-pw/send.json",
//                    data: {
//                        user: H,
//                        answer: I
//                    },
//                    success: function(K) {
//                        if (K.result == "succeed") {
//                            var J = e("#login-findpw-cube").find(".cube");
//                            J.eq(0).children().first().html(K.message);
//                            J.eq(0).css("display", "");
//                            J.eq(1).css("display", "none")
//                        } else {
//                            if (K.message) {
//                                var L = e("#login-error-cube");
//                                L.find(".cube > div:eq(0)").html(K.message);
//                                L.css("top", "0")
//                            }
//                        }
//                    },
//                    dataType: "json",
//                    hideLoading: true
//                })
//            }
//            e(document.body).on("click", "#btn-send-pw", D);
//            e(document.body).on("keyup", "#findpw-ans", function(H) {
//                if (H.keyCode == 13) {
//                    D()
//                }
//            })
//        }
//    })();
    e(document.body).on("click", "#btn-user-init", function() {
        var H = document.getElementsByName("userId"),
            F = document.getElementById("new_pwd"),
            E = document.getElementById("cfm_pwd"),
            D = document.getElementById("find_qst"),
            J = document.getElementById("find_ans"),
            G = '<div class="layer-alert"><img src="/resources/image/alert.png" alt="alert" /> #{MESSAGE}#</div>',
            K = true;
        e(".layer-alert").remove();
        if (F.value.length == 0) {
            e(F).after(z.replace(G, {
                MESSAGE: q.user["empty.password.new"]
            }));
            K = false
        } else {
            if (/[0-9]/g.test(F.value) == false || /[a-z]/gi.test(F.value) == false || F.value.length < 8) {
                e(F).after(z.replace(G, {
                    MESSAGE: q.user["simple.password"]
                }));
                K = false
            } else {
                if (H[0].value == F.value) {
                    e(F).after(z.replace(G, {
                        MESSAGE: q.user["same.id"]
                    }));
                    K = false
                } else {
                    if (E.value.length == 0) {
                        e(E).after(z.replace(G, {
                            MESSAGE: q.user["empty.confirm"]
                        }));
                        K = false
                    } else {
                        if (F.value != E.value) {
                            e(E).after(z.replace(G, {
                                MESSAGE: q.user["diff.confirm"]
                            }));
                            K = false
                        }
                    }
                }
            }
        }
        if (D.value.length == 0) {
            e(D).after(z.replace(G, {
                MESSAGE: q.user["empty.question"]
            }));
            K = false
        }
        if (J.value.length == 0) {
            e(J).after(z.replace(G, {
                MESSAGE: q.user["empty.answer"]
            }));
            K = false
        }
        if (!K) {
            return
        }
        var I = document.getElementById("form-user");
        e.ajax({
            type: "POST",
            url: I.action + ".json",
            data: e(I).serialize(),
            success: function() {
                I.action = "/login-check";
                I.submit()
            },
            dataType: "json",
            hideLoading: true
        })
    });
    e(document.body).on("click", "#btn_user_option", function(E) {
        var F = e(E.currentTarget),
            D = e(e("#layer-user-setting").text());
        D.on("click", function(H) {
            var G = e(H.currentTarget).attr("data-rel");
            if (G) {
                location.href = G
            }
        });
        F.popoverdialog({
            content: D,
            offset: {
                top: 20,
                right: 5
            },
            widthFitContent: true
        })
    });
    e(document.body).on("click", "#btn-open-shared", function() {
        var D = e("#shared-key-layer"),
            E = document.getElementById("find_qst"),
            F = document.getElementById("find_ans");
        if (D.is(":visible")) {
            D.css("display", "none");
            E.disabled = true;
            F.disabled = true
        } else {
            D.css("display", "");
            E.disabled = false;
            F.disabled = false
        }
    });
    e(document.body).on("click", "#btn-user-passwd", function(E) {
        var K = e(E.currentTarget),
            H = document.getElementsByName("userId"),
            I = document.getElementById("cur_pwd"),
            L = document.getElementById("new_pwd"),
            D = document.getElementById("cfm_pwd"),
            F = document.getElementById("find_qst"),
            N = document.getElementById("find_ans"),
            G = '<div class="layer-alert"><img src="/resources/image/alert.png" alt="alert" /> #{MESSAGE}#</div>',
            M = true;
        e(".layer-alert").remove();
        if (I.value.length == 0) {
            e(I).after(z.replace(G, {
                MESSAGE: q.user["empty.password.cur"]
            }));
            M = false
        }
        if (L.value.length == 0) {
            e(L).after(z.replace(G, {
                MESSAGE: q.user["empty.password.new"]
            }));
            M = false
        } else {
            if (/[0-9]/g.test(L.value) == false || /[a-z]/gi.test(L.value) == false || L.value.length < 8) {
                e(L).after(z.replace(G, {
                    MESSAGE: q.user["simple.password"]
                }));
                M = false
            } else {
                if (I.value == L.value) {
                    e(L).after(z.replace(G, {
                        MESSAGE: q.user["same.password"]
                    }));
                    M = false
                } else {
                    if (H[0].value == L.value) {
                        e(L).after(z.replace(G, {
                            MESSAGE: q.user["same.id"]
                        }));
                        M = false
                    } else {
                        if (D.value.length == 0) {
                            e(D).after(z.replace(G, {
                                MESSAGE: q.user["empty.confirm"]
                            }));
                            M = false
                        } else {
                            if (L.value != D.value) {
                                e(D).after(z.replace(G, {
                                    MESSAGE: q.user["diff.confirm"]
                                }));
                                M = false
                            }
                        }
                    }
                }
            }
        }
        if (!F.disabled && F.value.length == 0) {
            e(F).after(z.replace(G, {
                MESSAGE: q.user["empty.question"]
            }));
            M = false
        }
        if (!F.disabled && N.value.length == 0) {
            e(N).after(z.replace(G, {
                MESSAGE: q.user["empty.answer"]
            }));
            M = false
        }
        if (!M) {
            return
        }
        var J = document.getElementById("form-user");
        e.ajax({

            type: "POST",
            url: J.action + ".json",
            data: e(J).serialize(),
            success: function() {
                K.noticepopup(q.changed);
                I.value = "";
                L.value = "";
                D.value = "";
                F.selectedIndex = -1;
                N.value = ""
            },
            dataType: "json"
        })
    });

    function l() {
        var D = document.getElementById("info-password"),
            E = '<div class="layer-alert"><img src="/resources/image/alert.png" alt="alert" /> #{MESSAGE}#</div>',
            F = true;
        if (D.value.length == 0) {
            e(D).after(z.replace(E, {
                MESSAGE: q.user["empty.password.cur"]
            }));
            F = false
        }
        if (!F) {
            return
        }
        e.ajax({
            type: "POST",
            url: "/user/info-secure.json",
            data: {
                password: D.value
            },
            success: function(H) {
                if (H && H.personal) {
                    var G = H.personal;
                    document.getElementById("info-name").value = G.username;
                    document.getElementById("info-name-eng").value = G.notation;
                    document.getElementById("info-phone").value = G.phone;
                    document.getElementById("info-email").value = G.email;
                    document.getElementById("info-fax").value = G.fax;
                    document.getElementById("secure-check-layer").style.display = "none";
                    document.getElementById("info-edit-layer").style.display = "";
                    document.getElementById("btn-user-check").style.display = "none";
                    document.getElementById("btn-user-info").style.display = ""
                }
            },
            dataType: "json"
        })
    }
    e(document.body).on("click", "#btn-user-check", l);
    e(document.body).on("keyup", "#info-password", function(D) {
        if (D.keyCode == 13) {
            l()
        }
    });
    e(document.body).on("click", "#btn-user-info", function(H) {
        var J = e(H.currentTarget),
            K = document.getElementById("info-name"),
            D = document.getElementById("info-phone"),
            E = document.getElementById("info-email"),
            F = '<div class="layer-alert"><img src="/resources/image/alert.png" alt="alert" /> #{MESSAGE}#</div>',
            I = true;
        if (K.value.length == 0) {
            e(K).after(z.replace(F, {
                MESSAGE: q.user["empty.username"]
            }));
            I = false
        }
        if (D.value.length == 0) {
            e(D).after(z.replace(F, {
                MESSAGE: q.user["empty.phone"]
            }));
            I = false
        }
        if (E.value.length == 0) {
            e(E).after(z.replace(F, {
                MESSAGE: q.user["empty.email"]
            }));
            I = false
        }
        if (!I) {
            return
        }
        var G = document.getElementById("form-user");
        e.ajax({
            type: "POST",
            url: G.action + ".json",
            data: e(G).serialize(),
            success: function() {
                J.noticepopup(q.changed)
            },
            dataType: "json"
        })
    });
    e(document.body).on("click", "#home-case-newest tbody tr,#home-case-expedited tbody tr", function(E) {
        var F = e(E.currentTarget),
            D = F.attr("data-url");
        if (!D) {
            return false
        }
        location.href = D;
        return false
    });
    e(document.body).on("click", "#sub-navigation a", function(E) {
        var D = e(E.currentTarget).find("span.navi-disabled").length > 0;
        if (D) {
            if (document.addEventListener) {
                E.preventDefault();
                E.stopPropagation()
            } else {
                if (document.attachEvent) {
                    E.returnValue = false
                }
            }
        }
        return !D
    });

    function r(I) {
        if (e.isArray(I)) {
            var J = ["["];
            for (var H = 0, G = I.length; H < G; H++) {
                J.push(r(I[H]))
            }
            J.push("]");
            return J.join("")
        } else {
            var F = [];
            for (var E in I) {
                var D = ['"', E, '":'];
                if (e.isNumeric(I[E])) {
                    D.push(I[E])
                } else {
                    D.push('"');
                    D.push((I[E] + "").replace(/"/, '"'));
                    D.push('"')
                }
                F.push(D.join(""))
            }
            return "{" + F.join(",") + "}"
        }
    }

    function p(F) {
        var E;
        try {
            if (JSON && JSON.stringify) {
                E = JSON.stringify(F)
            } else {
                E = r(F)
            }
        } catch (D) {
            E = r(F)
        }
        return E
    }

    function u(R, U, Q) {
        var M = Q.find("#event-relation-wrap"),
            N = M.find("tbody tr:not(.tr-nodata)"),
            D = N.length,
            T = (D > 0 && D % 2 == 0) ? D / 2 : 0,
            J = [];
        if (D == 0) {
            alert("There is no data.");
            return
        }
        for (var O = 0; O < T; O++) {
            var F = N.eq(O * 2),
                E = N.eq((O * 2) + 1),
                K = e([]),
                H = {};
            e.merge(e.merge(K, F.find('input[type="hidden"]')), E.find('input[type="hidden"]'));
            for (var S = 0, P = K.length; S < P; S++) {
                var G = K.eq(S),
                    L = G.prop("name");
                if (/^(AE_RELATION_(REP|SPN)_\d+)-\d+-\d+$/.test(L)) {
                    L = L.replace(/^(AE_RELATION_(REP|SPN)_\d+)-\d+-\d+$/, "$1")
                }
                H[L] = G.prop("value")
            }
            J.push(H)
        }
        var I = {
            itemValues: p(J)
        };
        if (R) {
            e.extend(I, R)
        }
        e.ajax({
            type: "POST",
            url: "/case/event-relation.json",
            data: I,
            success: function(V) {
                U.call(this, V);
                if (V.succeed) {
                    Q.find("." + a).remove()
                }
            },
            dataType: "json",
            traditional: true
        })
    }

    function i(T, U, Y, S) {
        if (S === undefined || S.length == 0) {
            S = e(".case-entry-wrap:visible")
        }
        if (S.prop("id") == "case-RELATION") {
            u(U, Y, S);
            return
        }
        S.find(".item-mandatory").remove();
        S.find("." + a).filter(function() {
            return e(this).children().length == 0
        }).remove();
        S.find(".label-warning").removeClass("label-warning");
        var N = S.find("input,textarea,select").filter(function() {
                return !/(radio|button)/i.test(this.type) && this.name !== undefined
            }),
            M = [];
        if (/composite/i.test(S.data("pagetype"))) {
            var Q = S.find("._paging-form-wrap");
            if (Q.is(":hidden")) {
                var F = Q.find(N);
                N = N.not(F)
            }
        }
        var W = N.filter(function() {
                return this.value.replace(/\s/g, "").length == 0 && e(this).is('[required="required"]')
            }),
            O = true;
        if (W.length > 0) {
            O = false;
            var D = W.closest(".item-row-wrap");
            for (var R = 0, G = D.length; R < G; R++) {
                var E = D.eq(R),
                    X = E.next(),
                    V = '<div class="item-mandatory"><div>' + q.mandatoryItem + "</div></div>";
                if (X.is("." + a)) {
                    X.prepend(V)
                } else {
                    E.after('<div class="screen-visible ' + a + '">' + V + "</div>")
                }
            }
            D = W.closest(".item-group");
            for (var R = 0, G = D.length; R < G; R++) {
                var E = D.eq(R).parent(),
                    X = E.next(),
                    V = '<div class="item-mandatory"><div>' + q.mandatoryItem + "</div></div>";
                if (X.is("." + a)) {
                    X.prepend(V)
                } else {
                    E.after('<div class="screen-hidden ' + a + '">' + V + "</div>")
                }
            }
            W.closest(".item-wrap").prev().find(".item-label > div").addClass("label-warning")
        }
        var P = S.closest(".case-entry-wrap").prop("id");
        if (P.length > 0) {
            O = v.query(P, q.query) && O
        }
        if (!O) {
            return false
        }
        var I = function() {
            var ac = S.find(".item-eng"),
                ab = ["[", String.fromCharCode(15), "BLND", String.fromCharCode(15), "]"].join(""),
                ai = N.filter("[data-itemkey]"),
                ag = S.is("._paging-form-wrap") ? S : S.find("._paging-form-wrap");
            for (var ae = 0, ak = ai.length; ae < ak; ae++) {
                var ah = ai.eq(ae),
                    af = ah.closest(".item-wrap"),
                    aa = parseInt(ah.attr("data-itemkey"), 10),
                    Z = {
                        ITEM_KEY: aa,
                        ITEM_ID: ah[0].name
                    },
                    aj = ac.filter('[data-itemkey="' + aa + '"]');
                if (ah.prop("disabled") && ah.prop("className").indexOf(d) == -1 && af.is(".item-blind") && !af.is(".item-deleted")) {
                    Z.VALUE = ab
                } else {
                    if (ah.is(":checkbox")) {
                        Z.VALUE = ah.prop("checked") ? ah.val() : ""
                    } else {
                        Z.VALUE = ah.val()
                    }
                }
                if (aj.length == 1) {
                    Z.VALUE_EXT = B(aj.html())
                }
                if (ag.find(ah).length > 0) {
                    if (U["page-no"]) {
                        Z.ROW_NP = U["page-no"]
                    } else {
                        Z.ROW_NP = "-1"
                    }
                } else {
                    Z.ROW_NP = "0"
                }
                M.push(Z)
            }
            var ad = {
                itemValues: p(M)
            };
            if (U) {
                e.extend(ad, U)
            }
            e.ajax({
                type: "POST",
                url: T + ".json",
                data: ad,
                success: function(al) {
                    Y.call(this, al);
                    if (al.succeed) {
                        S.find("." + a).remove()
                    }
                },
                dataType: "json",
                traditional: true
            })
        };
        var L = N.filter(function() {
                return this.type == "file" && this.className.indexOf(A) > -1
            }),
            K = L.length;
        if (K > 0) {
            var J = S.closest(".case-entry-wrap"),
                H = 0;
            J.on("uploadComplete.file", function() {
                H++;
                if (H == K) {
                    J.off("uploadComplete.file");
                    I()
                }
            });
            J.trigger("fileUploadRequest.entry")
        } else {
            I()
        }
        return true
    }

    function n(ac, ag) {
        var S = ac.find("input,textarea,select").filter("[data-itemkey]");
        for (var aj = 0, G = S.length; aj < G; aj++) {
            var X = S.eq(aj),
                L = X.attr("data-itemkey"),
                ab = undefined,
                J = undefined;
            for (var Z = 0, Y = ag.length; Z < Y; Z++) {
                if (ag[Z]["ITEM_KEY"] == L) {
                    ab = ag[Z]["VALUE"];
                    J = ag[Z]["VALUE_EXT"];
                    break
                }
            }
            if (X.is('[data-type="toggleradio"]')) {
                var U = document.getElementsByName(X[0]["id"] + "-r");
                if (ab === undefined || ab.length == 0) {
                    X.val("")
                } else {
                    X.val(ab)
                }
                var I = false;
                for (var ad = 0, ah = U.length; ad < ah; ad++) {
                    if (U[ad].value == ab) {
                        U[ad].checked = true;
                        I = true;
                        break
                    }
                }
                if (!I) {
                    for (var ad = 0, ah = U.length; ad < ah; ad++) {
                        U[ad].checked = false
                    }
                }
            } else {
                if (X.is('[type="checkbox"]')) {
                    X.prop("checked", (X.val() == ab))
                } else {
                    if (X.is("select")) {
                        var Q = X[0].options,
                            H = false;
                        for (var ae = 0, V = Q.length; ae < V; ae++) {
                            if (Q[ae].value == ab) {
                                Q[ae].selected = true;
                                H = true;
                                break
                            }
                        }
                        if (!H) {
                            for (var ae = 0, V = Q.length; ae < V; ae++) {
                                Q[ae].selected = false
                            }
                        }
                    } else {
                        if (X.is('[data-datatype="file"]')) {
                            var am = e(document.getElementById(X.prop("name") + "-download"));
                            if (ab === undefined || ab.length == 0) {
                                am.removeClass("btn-active").addClass("btn-inactive")
                            } else {
                                am.addClass("btn-active").removeClass("btn-inactive")
                            }
                        }
                        X.val(ab || "");
                        var M = X.parent().next(".item-eng"),
                            R = M.length;
                        if (J === undefined && R > 0) {
                            M.remove()
                        } else {
                            if (J !== undefined && R > 0) {
                                M.html(s(J))
                            } else {
                                if (J !== undefined && R == 0) {
                                    X.parent().after(z.replace(z.html.englishNotation, {
                                        ITEM: X.attr("data-itemkey"),
                                        CONTENT: s(J)
                                    }))
                                }
                            }
                        }
                    }
                }
            }
        }
        var O = ac.find('[name="fileUpload"]');
        for (var ak = 0, E = O.length; ak < E; ak++) {
            var N = O.eq(ak),
                T = N.clone();
            N.replaceWith(T);
            y(T)
        }
        var D = S.filter(".hasDatepicker");
        for (var al = 0, W = D.length; al < W; al++) {
            var F = D.eq(al),
                an = F.prop("id");
            if (!/_(BEGIN|END)_DATE$/i.test(an)) {
                var ai = F.val();
                F.datepicker("option", {
                    minDate: null,
                    maxDate: "+0d"
                });
                F.val(ai);
                continue
            }
            if (!/_BEGIN_DATE$/i.test(an)) {
                continue
            }
            var af = an.replace(/_BEGIN_DATE$/i, "_END_DATE"),
                K = D.filter(function() {
                    return this.id == af
                });
            if (K.length == 1) {
                var aa = F.val(),
                    P = K.val();
                if (aa && aa.length > 0 && aa != "UKUK-UK-UK") {
                    aa = aa.replace(/UK/g, "01")
                } else {
                    aa = null
                }
                var ai = K.val();
                K.datepicker("option", "minDate", aa);
                if (!aa || (function() {
                        var aq = ai.split("-"),
                            ap = aa.split("-");
                        for (var ao = 0; ao < 3; ao++) {
                            if (/UK/g.test(aq[ao]) || aq[ao] < ap[ao]) {
                                return true
                            }
                        }
                        return false
                    }())) {
                    K.val(ai)
                }
                if (P && P.length > 0 && P != "UKUK-UK-UK") {
                    if (/^\d\d\d\d-UK-UK$/.test(P)) {
                        P = P.replace(/UK-UK$/, "12-31")
                    } else {
                        if (/^\d\d\d\d-\d\d-UK$/.test(P)) {
                            P = P.replace(/^(\d\d\d\d)-(\d\d)-UK$/, function() {
                                var aq = arguments,
                                    ap = parseInt(aq[1], 10),
                                    ar = parseInt(aq[2], 10),
                                    ao;
                                switch (ar) {
                                    case 1:
                                    case 3:
                                    case 5:
                                    case 7:
                                    case 8:
                                    case 10:
                                    case 12:
                                        ao = 31;
                                        break;
                                    case 4:
                                    case 6:
                                    case 9:
                                    case 11:
                                        ao = 30;
                                        break;
                                    case 2:
                                        ao = (ap % 4 == 0 ? 29 : 28);
                                        break
                                }
                                return [aq[1], aq[2], ao].join("-")
                            })
                        }
                    }
                } else {
                    P = "+0d"
                }
                var ai = F.val();
                F.datepicker("option", "maxDate", P);
                if (!P || (function() {
                        var aq = ai.split("-"),
                            ap = P.split("-");
                        for (var ao = 0; ao < 3; ao++) {
                            if (/UK/g.test(aq[ao]) || aq[ao] > ap[ao]) {
                                return true
                            }
                        }
                        return false
                    }())) {
                    F.val(ai)
                }
            }
        }
        ac.find("." + a).remove();
        ac.find(".label-warning").removeClass("label-warning")
    }

    function w(K, E) {
        var O = K.find(".item-table-wrap"),
            N = O.find("._summary-template").text(),
            H = [],
            G = {};
        e.each(K.find("select"), function(T, R) {
            var X = e(R).attr("data-itemkey"),
                W = {},
                S = R.options;
            if (X === undefined) {
                return
            }
            for (var V = 0, U = S.length; V < U; V++) {
                if (S[V].value.length == 0) {
                    continue
                }
                W[S[V].value] = S[V].text
            }
            G[X] = W
        });
        e.each(K.find("input[data-itemkey]"), function(U, X) {
            var W = e(X),
                S = W.attr("data-itemkey");
            if (X.type == "checkbox") {
                var Y = X.value;
                G[S] = {};
                G[S][Y] = W.closest("label").text()
            } else {
                if (W.is('[data-type="toggleradio"]')) {
                    var Z = {},
                        V = document.getElementsByName(W.prop("name") + "-r");
                    for (var R = 0, T = V.length; R < T; R++) {
                        if (V[R].value.length == 0) {
                            continue
                        }
                        Z[V[R].value] = e(V[R]).closest("label").text()
                    }
                    G[S] = Z
                }
            }
        });
        for (var J = 0, Q = E.length; J < Q; J++) {
            var M = E[J],
                D = M.ROW_NP,
                F = M.ITEM_KEY;
            if (D < 1) {
                continue
            }
            while (H.length < D) {
                H.push({})
            }
            if (G[F]) {
                H[D - 1]["ITEM_" + F] = G[F][M.VALUE]
            } else {
                H[D - 1]["ITEM_" + F] = (M.VALUE || "")
            }
            if (M.DEL_FLAG == "Y") {
                H[D - 1]["TR_DEL_CLASS"] = "_page-deleted";
                H[D - 1]["TD_DEL_CLASS"] = "deleted"
            }
        }
        var L = [];
        for (var P = 0, I = H.length; P < I; P++) {
            H[P]["PAGE_NO"] = (P + 1);
            L.push(z.replace(N, H[P]))
        }
        O.find("table tbody").html(L.join(""))
    }

    function o(R, M) {
        var L = R.find("input,textarea").filter(function() {
                return !/(button|radio)/i.test(this.type)
            }),
            Z = R.find("select");
        if (M) {
            L = L.filter(function() {
                return !(this.className.indexOf(d) > -1)
            });
            Z = Z.filter(function() {
                return !(this.className.indexOf(d) > -1)
            })
        }
        for (var W = 0, P = L.length; W < P; W++) {
            var Q = L.eq(W);
            Q.trigger("regist.detect");
            if (/(radio|checkbox)/i.test(Q.prop("type"))) {
                Q.prop("checked", false)
            } else {
                if (/toggleradio/i.test(Q.attr("data-type"))) {
                    var G = document.getElementsByName(Q.prop("id") + "-r");
                    for (var O = 0, H = G.length; O < H; O++) {
                        G[O].checked = false
                    }
                    Q.val("");
                    Q.trigger("click")
                } else {
                    if (/file/i.test(Q.prop("type"))) {
                        var E = Q.closest(".case-entry-wrap"),
                            T = Q.clone();
                        if (e._data(E[0]).events != undefined) {
                            e.each(e._data(E[0]).events, function(ab, ac) {
                                if (ab == "fileUploadRequest") {
                                    e.each(ac, function(ad, ae) {
                                        if (ae.data == Q.prop("id").replace(/-file$/i, "")) {
                                            ac.splice(ad, 1)
                                        }
                                    })
                                }
                            })
                        }
                        Q.replaceWith(T);
                        y(T);
                        Q.trigger("blur")
                    } else {
                        if (Q.data("datatype") == "MEDCOD") {
                            var aa = Q.closest(".item-row-wrap"),
                                J = Q.prop("name").replace(/^(.+_(MFDS_INGR|MFDS_DM|KCD|MEDDRA|WHOART|ATC))_.+$/i, "$1"),
                                U = new RegExp("^" + J + "_([a-zA-Z0-9_]+)$"),
                                D = aa.find("input,textarea");
                            for (var V = 0, F = D.length; V < F; V++) {
                                var K = D.eq(V);
                                if (U.test(K.prop("name"))) {
                                    K.val("");
                                    D.trigger("blur")
                                }
                            }
                            Q.val("");
                            Q.trigger("blur")
                        } else {
                            Q.val("");
                            Q.trigger("blur")
                        }
                    }
                }
            }
        }
        L.filter(".hasDatepicker").datepicker("option", {
            minDate: null,
            maxDate: "+0d"
        });
        for (var N = 0, Y = Z.length; N < Y; N++) {
            var I = Z[N].options;
            for (var S = 0, X = I.length; S < X; S++) {
                I[S].selected = false
            }
        }
        R.find('input[type="button"].btn-active[id$="-download"]').each(function(ac, ab) {
            ab.className = ab.className.replace(/btn-active/, "btn-inactive")
        });
        R.find(".item-eng").remove();
        R.find("." + a).remove();
        R.find(".label-warning").removeClass("label-warning")
    }

    function C(E, D, F, I) {
        var H = E.find(".item-wrap");
        if (D || (F !== undefined && F)) {
            var G = E.find(".item-table-wrap").find("table tbody tr:not(.tr-nodata)");
            if (I === undefined) {
                G.find("td").addClass("deleted")
            } else {
                G.filter('[data-pageno="' + I + '"]').find("td").addClass("deleted")
            }
            H.addClass("item-deleted").find("input,textarea,select").prop("disabled", true);
            E.find(".item-group-icon,.item-icon").find("a").not(".a-disabled").not(':has(img[data-role^="more-"])').addClass("a-disabled").find("img").each(function(K, J) {
                J.src = J.src.replace(/on.png$/i, "off.png")
            });
            E.find("." + a).remove();
            E.find(".label-warning").removeClass("label-warning")
        } else {
            E.find(".item-table-wrap").find("table tbody tr:not(.tr-nodata,._page-deleted)").find("td").removeClass("deleted");
            H.filter(".item-deleted").removeClass("item-deleted").find("input,textarea,select").prop("disabled", false);
            E.find(".item-group-icon,.item-icon").find("a").filter(".a-disabled").removeClass("a-disabled").find("img").each(function(K, J) {
                J.src = J.src.replace(/off.png$/i, "on.png")
            });
            E.find("." + a).remove();
            E.find(".label-warning").removeClass("label-warning")
        }
    }
    var t = 0;

    function m(H, F) {
        t += 1;
        var D = window,
            G = e('<form style="display:none;"></form>'),
            E = e('<iframe src="javascript:false;" name="iframe-download-' + t + '"></iframe>').bind("load", function() {
                E.unbind("load").bind("load", function() {
                    if (E.contents().find("#form-login").length > 0) {
                        D.location.href = D.location.pathname
                    } else {
                        e('<iframe src="javascript:false;"></iframe>').appendTo(G);
                        window.setTimeout(function() {
                            G.remove()
                        }, 0)
                    }
                })
            });
        G.prop("target", E.prop("name")).prop("action", H).prop("method", "POST");
        if (F) {
            G.html(F.join(""))
        }
        G.append(E).appendTo(document.body);
        G.submit()
    }

    function s(D) {
        if (D === undefined || D.length == 0) {
            return ""
        }
        return D.replace(/\n/g, "<br/>").replace(/&<>"'/g, function() {
            var E = arguments[1];
            switch (E) {
                case "<":
                    E = "lt";
                    break;
                case ">":
                    E = "gt";
                    break;
                case "&":
                    E = "amp";
                    break;
                case '"':
                    E = "quot";
                    break;
                case "'":
                    E = "apos";
                    break
            }
            return "&".concat(E, ";")
        })
    }

    function B(D) {
        if (D.length == 0) {
            return ""
        }
        return D.replace(/&([a-z]+);/g, function() {
            var E = arguments[1];
            switch (E) {
                case "lt":
                    E = "<";
                    break;
                case "gt":
                    E = ">";
                    break;
                case "amp":
                    E = "&";
                    break;
                case "quot":
                    E = '"';
                    break;
                case "apos":
                    E = "'";
                    break;
                default:
                    E = arguments[0];
                    break
            }
            return E
        }).replace(/<\s*br\s*\/?>/gi, "\n")
    }

    function k(F, N) {
        var J = N.find("input,textarea").filter(function() {
            if (/textarea/i.test(this.tagName)) {
                return true
            }
            if (this.type != "text") {
                return false
            }
            var V = e(this).attr("data-datatype");
            return (V !== undefined && V.length == 1 && V != "N")
        });
        if (J.length == 0) {
            return false
        }
        var P = [];
        if (J.length > 0) {
            var H = [],
                G = [],
                M = {
                    WRAP_STYLE: "",
                    SOURCE_LABEL: (q.notationSourceLabel || "Original Text"),
                    SOURCE_CONTENT: "",
                    NOTATION_LABEL: (q.notationEnglishLabel || "English Notation"),
                    NOTATION_CONTENT: "",
                    ITEM_ID: "",
                    MAX_LENGTH: "",
                    ORIGIN_CONTENT: ""
                };
            for (var Q = 0, L = J.length; Q < L; Q++) {
                var E = J.eq(Q),
                    K = E.prop("name"),
                    U = E.val(),
                    D = E.parent().next(".item-eng"),
                    I = D.length > 0 ? D.html() : "";
                if (Q > 0) {
                    M.WRAP_STYLE = ' style="display:none;"'
                }
                var T = undefined;
                if (E.is("textarea")) {
                    U = s(U);
                    T = z.html.textareaNotation
                } else {
                    U = U.replace(/"/g, "&quot;");
                    T = z.html.inputNotation
                }
                if (T) {
                    H.push(z.replace(z.html.defaultOption, {
                        VALUE: K,
                        LABEL: E.closest(".item-group").find(".item-label > div:eq(0)").html()
                    }));
                    G.push(z.replace(T, e.extend({}, M, {
                        SOURCE_CONTENT: U,
                        NOTATION_CONTENT: B(I).replace(/"/g, "&quot;"),
                        ORIGIN_CONTENT: I,
                        ITEM_ID: K,
                        MAX_LENGTH: E.attr("maxlength")
                    })))
                }
            }
            if (J.length > 1) {
                P.push(z.replace(z.html.notationItems, {
                    NOTATION_ITEM_OPTIONS: H.join("")
                }))
            }
            P.push(G.join(""))
        }
        var R = {};
        R[(q.confirm || "Saved")] = function(V, ad) {
            var W = ad.find(".right").filter(":visible"),
                X = W.find("input,textarea"),
                Z = X.prop("id").replace(/^notation-/, ""),
                ab = J.filter(function() {
                    return this.name == Z
                });
            if (ab.length > 0) {
                var aa = e.trim(X.val()),
                    Y = ab.parent().next(".item-eng");
                if (aa.length == 0) {
                    if (Y) {
                        Y.remove()
                    }
                } else {
                    var ac = z.replace(z.html.englishNotation, {
                        ITEM: ab.attr("data-itemkey"),
                        CONTENT: s(aa)
                    });
                    if (Y.length == 0) {
                        ab.parent().after(ac)
                    } else {
                        Y.replaceWith(ac)
                    }
                }
            }
            e.popoverdialog("close")
        };
        R[(q.cancel || "Cancel")] = function() {
            e.popoverdialog("close")
        };
        var O, S;
        if (F.parents(".item-group-icon").length > 0) {
            O = N.closest(".item-row-wrap")
        } else {
            O = N.parent();
            if (O.is(".item-group-wrap1")) {
                S = {
                    top: "+" + O.parent().height()
                }
            } else {
                S = {
                    top: "+" + O.height()
                }
            }
        }
        N.popoverdialog({
            title: q.inputValueExtension || "English Notation",
            width: O.width(),
            content: '<div class="layer-contents">' + P.join("") + "</div>",
            buttons: R,
            offsetFix: S
        });
        return true
    }
    e(document.body).on("change", "#notation-items", function(F) {
        var H = e(F.currentTarget),
            E = H.prop("value"),
            D = H.closest(".layer-contents"),
            G = D.find("#notation-" + E);
        if (G.length > 0) {
            D.find("._notation-wrap:visible").css("display", "none");
            G.val(B(G.next().val()).replace(/"/g, "&quot;"));
            G.closest("._notation-wrap").css("display", "")
        }
    });

    function j(E, D) {
        var F = [];
        F.push(function() {
            var G = e('<a href="#" onclick="return false;"><div style="text-align:right;">Data Audit Trail</div></a>');
            G.bind("click", function() {
                var O = [];
                e.each(E.find("input,select,textarea"), function(P, Q) {
                    var R = e(Q).attr("data-itemkey");
                    if (R) {
                        O.push(R)
                    }
                });
                if (O.length == 0) {
                    return false
                }
                var L = document.getElementById("case-case"),
                    K, N, M, H;
                if (L && /\d+/.test(L.value)) {
                    K = "/case/data-audit-trail.json";
                    N = L.value;
                    M = e(".case-entry-wrap:visible").attr("data-pagekey");
                    var I = E.parents("._paging-form-wrap");
                    if (I.length > 0) {
                        H = I.children('[name="case-paging-entry"]').val()
                    }
                } else {
                    var J = document.getElementById("form-product") || document.getElementById("form-sponsor") || document.getElementById("form-manufacturer") || document.getElementById("form-customized");
                    if (J) {
                        K = J.action + "/data-audit-trail.json";
                        M = J.elements.page.value
                    } else {
                        J = document.getElementById("form-user");
                        if (J) {
                            K = J.action.replace(/submit$/, "data-audit-trail.json");
                            M = J.elements.page.value;
                            N = J.elements.user.value
                        } else {
                            J = document.getElementById("form-source");
                            if (J) {
                                K = J.action + "/" + J.elements.entry.value + "/data-audit-trail.json";
                                M = J.elements.page.value
                            } else {
                                J = document.getElementById("form-paging-entry");
                                K = J.action.replace(/submit$/i, "data-audit-trail.json");
                                N = document.getElementById("paging-entry-key").value;
                                M = document.getElementById("paging-entry-page").value
                            }
                        }
                    }
                }
                e.ajax({
                    url: K,
                    data: {
                        page: M,
                        entry: N,
                        pageNo: H,
                        items: O
                    },
                    dataType: "json",
                    method: "POST",
                    success: function(V) {
                        var R = {
                                NO: q.dataAuditTrailNo || "No",
                                DATETIME: q.dataAuditTrailDateTime || "DateTime",
                                USER: q.dataAuditTrailUser || "User",
                                ITEM: q.dataAuditTrailItem || "Item",
                                AFTER: q.dataAuditTrailAfter || "Value",
                                REASON: q.dataAuditTrailReason || "Reason"
                            },
                            Q, X, ac, S, ad, ab, U;
                        if (D.parents(".item-group-icon").length > 0) {
                            U = E.closest(".item-row-wrap");
                            Q = "screen-visible";
                            X = 6;
                            ab = z.html.dataAuditTrailHeader;
                            S = z.html.dataAuditTrailRow;
                            ad = z.html.dataAuditTrailRowWithNotation
                        } else {
                            U = E.parent();
                            Q = "screen-hidden";
                            X = 5;
                            ab = z.html.dataAuditTrailSmallHeader;
                            S = z.html.dataAuditTrailSmallRow;
                            ad = z.html.dataAuditTrailSmallRowWithNotation
                        }
                        if (V.dataAuditTrail === undefined || V.dataAuditTrail.length == 0) {
                            ac = z.replace(z.html.auditTrailNoData, {
                                COL_SPAN: X,
                                LABEL: q.auditTrailNoData || "Data does not exist."
                            })
                        } else {
                            var af = [];
                            for (var T = 0, ae = V.dataAuditTrail.length; T < ae; T++) {
                                var W = V.dataAuditTrail[T],
                                    P = W.AFTER_NOTATION;
                                W.AFTER = s(W.AFTER);
                                W.REASON = s(W.REASON);
                                if (P) {
                                    W.AFTER_NOTATION = s(W.AFTER_NOTATION);
                                    af.push(z.replace(ad, W))
                                } else {
                                    af.push(z.replace(S, W))
                                }
                            }
                            ac = af.join("")
                        }
                        var aa = U.next(),
                            Z = z.replace(z.html.auditTrailWrap, {
                                TITLE: q.dataAuditTrailTitle || "Data Audit Trail",
                                HEADER: z.replace(ab, R),
                                DATA_ROWS: ac
                            });
                        if (aa.is("." + a)) {
                            var Y = aa.find(".audit-trail");
                            if (Y.length > 0) {
                                Y.replaceWith(Z)
                            } else {
                                aa.append(Z)
                            }
                        } else {
                            U.after('<div class="' + Q + " " + a + '">' + Z + "</div>")
                        }
                        e.popoverdialog("close")
                    }
                });
                return false
            });
            return G
        }());
        D.popoverdialog({
            title: "",
            width: 130,
            content: F,
            buttons: undefined,
            offsetFix: {
                left: "-6",
                top: "-4"
            }
        })
    }

    function c(D, K, G, J, E, I) {
        var L = e(z.replace(z.html.editReasonContent, {
                LABEL: G,
                DEFAULT: (J || "")
            })),
            F = L.find("textarea"),
            H = {};
        H[(q.confirm || "Saved")] = function() {
            var M = e.trim(F.val());
            if (E && M.length == 0) {
                D.popoverdialog("refresh", {
                    alerts: E
                });
                return false
            }
            I.call(this, M);
            e.popoverdialog("close");
            return false
        };
        H[(q.cancel || "Cancel")] = function() {
            e.popoverdialog("close")
        };
        D.popoverdialog({
            title: K,
            width: 300,
            content: L,
            buttons: H
        })
    }

    function h(D, E) {
        c(D, (q.modifyReasonTitle || "Reason of modify"), (q.modifyReason || "Reason"), (q.modifyDefaultReason || "Entry Error"), [q.modifyReasonRequired || "Please list the reason for modify"], E)
    }

    function x(D, E, F) {
        if (E) {
            c(D, (q.deleteReasonTitle || "Reason of delete"), (q.deleteReason || "Reason"), "", [q.deleteReasonRequired || "Please list the reason for delete"], F)
        } else {
            c(D, (q.restoreReasonTitle || "Reason of restore"), (q.restoreReason || "Reason"), "", [q.restoreReasonRequired || "Please list the reason for restore"], F)
        }
    }
    e(document.body).on("click", "a._audit-trail-closer", function(D) {
        e(D.currentTarget).closest(".audit-trail").remove();
        return false
    });
    e(document.body).on("click", "#btn-sponsor-modify", function(E) {
        var G = e(E.currentTarget),
            D = document.getElementById("form-sponsor").action + ".json",
            F = {
                page: document.getElementById("sponsor-page").value
            };
        h(G, function(H) {
            F.reason = H;
            i(D, F, function(I) {
                if (I.succeed) {
                    G.noticepopup(q.succeedSave || "Saved");
                    e("._paging-form-wrap").detectchanged("init")
                } else {
                    G.errorpopup(q.failSave || "Fail to save. Check please.")
                }
            })
        })
    });
    e(document.body).on("click", "#btn-user-submit,#btn-user-modify", function(F) {
        var H = e(F.currentTarget),
            I = document.getElementById("form-user"),
            G = {
                page: document.getElementById("user-page").value,
                user: document.getElementById("user-id").value
            },
            E = I.action,
            D = function() {
                i(E, G, function(J) {
                    if (J.succeed) {
                        H.noticepopup(q.succeedSave || "Saved");
                        e("#btn-user-submit").css("display", "none");
                        e("#btn-user-modify,#btn-user-delete").css("display", "");
                        if (J.user) {
                            document.getElementById("user-id").value = J.user;
                            e(".item-group-icon,.item-icon").find('a.a-disabled:has(img[data-role^="more-"])').removeClass("a-disabled").find("img").prop("src", "/resources/image/more-on.png");
                            document.getElementById("user-label").innerHTML = J.user
                        }
                        e("._paging-form-wrap").detectchanged("init")
                    } else {
                        H.errorpopup(q.failSave || "Fail to save. Check please.")
                    }
                })
            };
        if (H.is("#btn-user-modify")) {
            h(H, function(J) {
                G.reason = J;
                D()
            })
        } else {
            D()
        }
        return false
    });
    e(document.body).on("click", "#btn-user-delete,#btn-user-restore", function(G) {
        var H = e(G.currentTarget),
            D = e(".case-entry-wrap"),
            E = H.is("#btn-user-delete"),
            F = document.getElementById("form-user");
        x(H, E, function(J) {
            var I = F.action.replace(/submit$/, (E ? "delete" : "restore")) + ".json";
            e.ajax({
                url: I,
                method: "POST",
                data: {
                    reason: J,
                    user: document.getElementById("user-id").value
                },
                dataType: "json",
                success: function(P) {
                    if (P.succeed) {
                        C(D, E);
                        var M = e("#bottom-wrap").find("a").filter("[id]"),
                            K, O, N;
                        if (E) {
                            var L;
                            O = K = L = e("#btn-user-restore");
                            N = q.succeedDelete || "Deleted";
                            L.css("display", "").noticepopup()
                        } else {
                            K = e("#btn-user-modify,#btn-user-delete,#btn-user-init-password");
                            O = K.eq(0);
                            N = q.succeedRestore || "Restored"
                        }
                        M.not(O).css("display", "none");
                        K.css("display", "");
                        O.noticepopup(N)
                    } else {
                        if (E) {
                            H.noticepopup(q.failDelete || "Fail to delete. Check please.")
                        } else {
                            H.noticepopup(q.failRestore || "Fail to restore. Check please.")
                        }
                    }
                }
            })
        });
        return false
    });
    e(document.body).on("click", "#btn-user-init-password", function(F) {
        var G = e(F.currentTarget),
            D = q.admin["user.initPasswordReasonTitle"] || "Reason of password initialize",
            E = q.admin["user.initPasswordReason"] || "Reason";
        c(G, D, E, undefined, undefined, function(H) {
            e.ajax({
                url: "/admin/user-init.json",
                method: "POST",
                data: {
                    reason: H,
                    user: document.getElementById("user-id").value
                },
                dataType: "json",
                success: function(I) {
                    if (I.message) {
                        e("#btn-user-init-password").noticepopup(I.message)
                    } else {
                        G.noticepopup(q.admin["user.failInitPassword"] || "Fail to password initialize. Check please.")
                    }
                }
            })
        });
        return false
    });
    e(document.body).on("click", "#btn-manufacturer-submit,#btn-manufacturer-modify", function(G) {
        var I = e(G.currentTarget),
            F = document.getElementById("form-manufacturer"),
            H = {
                page: document.getElementById("manufacturer-page").value
            },
            E = F.action,
            D = function() {
                i(E, H, function(J) {
                    if (J.succeed) {
                        I.noticepopup(q.succeedSave || "Saved");
                        e("#btn-manufacturer-submit").css("display", "none");
                        e("#btn-manufacturer-modify,#btn-manufacturer-delete").css("display", "");
                        if (J.manufacturer) {
                            F.action = F.action.replace(/\/0$/, "/" + J.manufacturer);
                            e("#sub-navigation").find("a span.navi-disabled").removeClass("navi-disabled");
                            e("#sub-navigation a,#source-navi").each(function(K, L) {
                                L.href = e(L).attr("href").replace(/(\/admin\/manufacturer\/)[^/]+/gi, "$1" + J.manufacturer)
                            });
                            e(".item-group-icon,.item-icon").find('a.a-disabled:has(img[data-role^="more-"])').removeClass("a-disabled").find("img").prop("src", "/resources/image/more-on.png")
                        }
                        if (J.label) {
                            document.getElementById("manufacturer-label").innerHTML = J.label
                        }
                        e("._paging-form-wrap").detectchanged("init")
                    } else {
                        I.errorpopup(q.failSave || "Fail to save. Check please.")
                    }
                })
            };
        if (I.is("#btn-manufacturer-modify")) {
            h(I, function(J) {
                H.reason = J;
                D()
            })
        } else {
            D()
        }
        return false
    });
    e(document.body).on("click", "#btn-manufacturer-delete,#btn-manufacturer-restore", function(G) {
        var H = e(G.currentTarget),
            D = e(".case-entry-wrap"),
            E = H.is("#btn-manufacturer-delete"),
            F = document.getElementById("form-manufacturer");
        x(H, E, function(J) {
            var I = F.action + "/" + (E ? "delete" : "restore") + ".json";
            e.ajax({
                url: I,
                method: "POST",
                data: {
                    reason: J
                },
                dataType: "json",
                success: function(L) {
                    if (L.succeed) {
                        C(D, E);
                        var K = e("#sub-navigation").find("a");
                        if (E) {
                            K.find("span:not(.current)").addClass("navi-disabled");
                            e("#btn-manufacturer-modify,#btn-manufacturer-delete").css("display", "none");
                            e("#btn-manufacturer-restore").css("display", "").noticepopup(q.succeedDelete || "Deleted")
                        } else {
                            K.find("span.navi-disabled").removeClass("navi-disabled");
                            H.css("display", "none");
                            e("#btn-manufacturer-modify,#btn-manufacturer-delete").css("display", "").eq(0).noticepopup(q.succeedRestore || "Restored")
                        }
                    } else {
                        if (E) {
                            H.noticepopup(q.failDelete || "Fail to delete. Check please.")
                        } else {
                            H.noticepopup(q.failRestore || "Fail to restore. Check please.")
                        }
                    }
                }
            })
        });
        return false
    });
    e(document.body).on("click", "#btn-product-submit,#btn-product-modify", function(F) {
        var I = e(F.currentTarget),
            E = document.getElementById("product-product"),
            G = document.getElementById("product-manufacturer"),
            H = {
                page: document.getElementById("product-page").value,
                product: E.value || undefined,
                manufacturer: G.value || undefined
            },
            D = function() {
                i(document.getElementById("form-product").action, H, function(L) {
                    if (L.succeed) {
                        I.noticepopup(q.succeedSave || "Saved");
                        e("#btn-product-submit").css("display", "none");
                        e("#btn-product-modify,#btn-product-delete").css("display", "");
                        E.value = L.product;
                        G.value = L.manufacturer;
                        document.getElementById("product-label").innerHTML = L.label;
                        var K = e("#sub-navigation").find("a");
                        K.find("span.navi-disabled").removeClass("navi-disabled");
                        K.each(function(M, N) {
                            N.href = e(N).attr("href").replace(/\/product\/new/gi, "/product/" + L.productCode)
                        });
                        var J = document.getElementById("product-navi");
                        J.href = e(J).attr("href").replace(/\/product\/new/gi, "/product/" + L.productCode) + "/trial";
                        e(".item-group-icon,.item-icon").find('a.a-disabled:has(img[data-role^="more-"])').removeClass("a-disabled").find("img").prop("src", "/resources/image/more-on.png");
                        e("._paging-form-wrap").detectchanged("init")
                    } else {
                        I.errorpopup(q.failSave || "Fail to save. Check please.")
                    }
                })
            };
        if (I.is("#btn-product-modify")) {
            h(I, function(J) {
                H.reason = J;
                D()
            })
        } else {
            D()
        }
        return false
    });
    e(document.body).on("click", "#btn-product-delete,#btn-product-restore", function(F) {
        var G = e(F.currentTarget),
            D = e(".case-entry-wrap"),
            E = G.is("#btn-product-delete");
        x(G, E, function(I) {
            var H = document.getElementById("form-product").action + "/" + (E ? "delete" : "restore") + ".json";
            e.ajax({
                url: H,
                method: "POST",
                data: {
                    reason: I
                },
                dataType: "json",
                success: function(L) {
                    if (L.succeed) {
                        C(D, E);
                        var J = e("#product-label").closest("a"),
                            K = e("#sub-navigation").find("a");
                        if (E) {
                            J.prop("href", K.filter(":has(span.current)").attr("href"));
                            K.find("span:not(.current)").addClass("navi-disabled");
                            e("#btn-product-modify,#btn-product-delete").css("display", "none");
                            e("#btn-product-restore").css("display", "").noticepopup(q.succeedDelete || "Deleted")
                        } else {
                            J.prop("href", K.eq(0).attr("href"));
                            K.find("span.navi-disabled").removeClass("navi-disabled");
                            G.css("display", "none");
                            e("#btn-product-modify,#btn-product-delete").css("display", "").eq(0).noticepopup(q.succeedRestore || "Restored")
                        }
                    } else {
                        if (E) {
                            G.noticepopup(q.failDelete || "Fail to delete. Check please.")
                        } else {
                            G.noticepopup(q.failRestore || "Fail to restore. Check please.")
                        }
                    }
                }
            })
        });
        return false
    });
    e(document.body).on("click", "#btn-source-submit,#btn-source-modify", function(G) {
        var I = e(G.currentTarget),
            F = document.getElementById("source-source"),
            H = {
                page: document.getElementById("source-page").value,
                product: document.getElementById("source-product").value,
                source: F.value
            },
            E = document.getElementById("form-source").action + "/" + F.value,
            D = function() {
                i(E, H, function(N) {
                    if (N.succeed) {
                        I.noticepopup(q.succeedSave || "Saved");
                        e("#btn-source-submit").css("display", "none");
                        e("#btn-source-modify,#btn-source-delete").css("display", "");
                        F.value = N.source;
                        document.getElementById("source-label").innerHTML = N.label;
                        var L = e("#sub-navigation").find("a");
                        L.find("span.navi-disabled").removeClass("navi-disabled");
                        e.merge(L, e("#source-navi")).each(function(O, P) {
                            P.href = e(P).attr("href").replace(/(\/product\/[^/]+\/[^/]+\/)[^/]+/gi, "$1" + N.source)
                        });
                        e(".item-group-icon,.item-icon").find('a.a-disabled:has(img[data-role^="more-"])').removeClass("a-disabled").find("img").prop("src", "/resources/image/more-on.png");
                        var J = document.getElementById("PLAN_CODE");
                        if (J && N.values) {
                            var M = e(J).data("itemkey") + "#0#0",
                                K;
                            if ((K = N.values[M]) && K.VALUE) {
                                J.value = K.VALUE
                            }
                        }
                        e("._paging-form-wrap").detectchanged("init")
                    } else {
                        I.errorpopup(q.failSave || "Fail to save. Check please.")
                    }
                })
            };
        if (I.is("#btn-source-modify")) {
            h(I, function(J) {
                H.reason = J;
                D()
            })
        } else {
            D()
        }
        return false
    });
    e(document.body).on("click", "#btn-source-delete,#btn-source-restore", function(G) {
        var H = e(G.currentTarget),
            D = e(".case-entry-wrap"),
            E = H.is("#btn-source-delete"),
            F = document.getElementById("form-source");
        x(H, E, function(J) {
            var I = F.action + "/" + F.elements.entry.value + "/" + (E ? "delete" : "restore") + ".json";
            e.ajax({
                url: I,
                method: "POST",
                data: {
                    reason: J
                },
                dataType: "json",
                success: function(M) {
                    if (M.succeed) {
                        C(D, E);
                        var K = e("#source-label").closest("a"),
                            L = e("#sub-navigation").find("a");
                        if (E) {
                            K.prop("href", L.filter(":has(span.current)").attr("href"));
                            L.find("span:not(.current)").addClass("navi-disabled");
                            e("#btn-source-modify,#btn-source-delete").css("display", "none");
                            e("#btn-source-restore").css("display", "").noticepopup(q.succeedDelete || "Deleted")
                        } else {
                            K.prop("href", L.eq(0).attr("href"));
                            L.find("span.navi-disabled").removeClass("navi-disabled");
                            H.css("display", "none");
                            e("#btn-source-modify,#btn-source-delete").css("display", "").eq(0).noticepopup(q.succeedRestore || "Restored")
                        }
                    } else {
                        if (E) {
                            H.noticepopup(q.failDelete || "Fail to delete. Check please.")
                        } else {
                            H.noticepopup(q.failRestore || "Fail to restore. Check please.")
                        }
                    }
                }
            })
        });
        return false
    });
    e(document.body).on("click", "#btn-paging-entry-add,#btn-paging-entry-add-more", function() {
        var F = e("#btn-paging-entry-add,#btn-paging-entry-add-more,#btn-paging-entry-list,#btn-paging-entry-modify,#btn-paging-entry-download,#btn-paging-entry-delete,#btn-paging-entry-restore,#button-excel-download"),
            E = e("#paging-entry-form-wrap,#btn-paging-entry-save,#btn-paging-entry-cancel"),
            D = e("#form-paging-entry").find(".case-entry-wrap"),
            G = document.getElementById("paging-entry-key");
        if (e("._paging-form-wrap").is(":visible") && e("._paging-form-wrap").detectchanged()) {
            if (!confirm(q.confirmWithoutSave || "Move to another page without saving?")) {
                return false
            }
        }
        D.find(".item-group-icon,.item-icon").find("a").not(".a-disabled").filter(':has(img[data-role^="more-"])').addClass("a-disabled").find("img").prop("src", "/resources/image/more-off.png");
        o(D);
        C(D, false);
        v.reset(D.prop("id"));
        F.css("display", "none");
        E.css("display", "");
        G.value = "-1";
        e("._paging-form-wrap").detectchanged("init");
        return false
    });
    e(document.body).on("click", "#btn-paging-entry-save,#btn-paging-entry-modify", function(F) {
        var K = e(F.currentTarget),
            G = document.getElementById("paging-entry-page"),
            J = document.getElementById("paging-entry-key"),
            H = (J.value || undefined),
            I = {
                page: G.value,
                entry: H
            },
            E = document.getElementById("form-paging-entry"),
            D = function() {
                i(E.action, I, function(O) {
                    if (O.succeed) {
                        var N = e(document.getElementById(q.listWrapId));
                        if (H) {
                            N.paginatedList("refresh")
                        } else {
                            N.paginatedList("reload")
                        }
                        var M = e("#btn-paging-entry-add,#btn-paging-entry-list,#btn-paging-entry-save,#btn-paging-entry-restore,#button-excel-download"),
                            L = e("#btn-paging-entry-add-more,#btn-paging-entry-modify,#btn-paging-entry-cancel,#btn-paging-entry-download,#paging-entry-form-wrap,#btn-paging-entry-delete");
                        M.css("display", "none");
                        L.css("display", "");
                        if (O.entry !== undefined) {
                            J.value = O.entry
                        }
                        e("#btn-paging-entry-modify").noticepopup(q.succeedSave || "Saved");
                        e("._paging-form-wrap").detectchanged("init")
                    } else {
                        K.errorpopup(q.failSave || "Fail to save. Check please.")
                    }
                })
            };
        if (K.is("#btn-paging-entry-modify")) {
            h(K, function(L) {
                I.reason = L;
                D()
            })
        } else {
            D()
        }
        return false
    });
    e(document.body).on("click", "#btn-paging-entry-cancel", function() {
        var E = e("#btn-paging-entry-add-more,#paging-entry-form-wrap,#btn-paging-entry-save,#btn-paging-entry-modify,#btn-paging-entry-cancel,#btn-paging-entry-download,#btn-paging-entry-delete,#btn-paging-entry-restore"),
            D = e("#btn-paging-entry-add,#btn-paging-entry-list,#button-excel-download");
        E.css("display", "none");
        D.css("display", "");
        return false
    });
    e(document.body).on("edit.paging-entry", "#paging-entry-form-wrap", function(D, F) {
        var E = document.getElementById("paging-entry-page"),
            H = F.entryLoadURL,
            G = F.entryKey;
        if (e("._paging-form-wrap").is(":visible") && e("._paging-form-wrap").detectchanged()) {
            if (!confirm(q.confirmWithoutSave || "Move to another page without saving?")) {
                return false
            }
        }
        e.ajax({
            url: H,
            data: {
                page: E.value,
                entry: G
            },
            method: "POST",
            dataType: "json",
            success: function(N) {
                var M = e("#btn-paging-entry-add,#btn-paging-entry-save,#btn-paging-entry-list,#button-excel-download"),
                    L = e("#btn-paging-entry-add-more,#paging-entry-form-wrap,#btn-paging-entry-cancel"),
                    K = e("#form-paging-entry").find(".case-entry-wrap"),
                    O = document.getElementById("paging-entry-key"),
                    J = N.itemValues,
                    I = N.deleted;
                if (I) {
                    e.merge(M, e("#btn-paging-entry-modify,#btn-paging-entry-download,#btn-paging-entry-delete"));
                    e.merge(L, e("#btn-paging-entry-restore"))
                } else {
                    e.merge(M, e("#btn-paging-entry-restore"));
                    e.merge(L, e("#btn-paging-entry-modify,#btn-paging-entry-download,#btn-paging-entry-delete"))
                }
                K.find(".item-group-icon,.item-icon").find('a.a-disabled:has(img[data-role^="more-"])').removeClass("a-disabled").find("img").prop("src", "/resources/image/more-on.png");
                n(K, J);
                C(K, I);
                v.reset(K.prop("id"));
                M.css("display", "none");
                L.css("display", "");
                O.value = G;
                e("._paging-form-wrap").detectchanged("init")
            }
        })
    });
    e(document.body).on("click", "#btn-paging-entry-delete,#btn-paging-entry-restore", function(G) {
        var J = e(G.currentTarget),
            D = e(".case-entry-wrap"),
            E = J.is("#btn-paging-entry-delete"),
            F = document.getElementById("form-paging-entry"),
            H = document.getElementById("paging-entry-page"),
            I = document.getElementById("paging-entry-key");
        x(J, E, function(L) {
            var K = F.action.replace(/\/submit$/i, ("/" + (E ? "delete" : "restore") + ".json"));
            e.ajax({
                url: K,
                method: "POST",
                data: {
                    page: H.value,
                    entry: I.value,
                    reason: L
                },
                dataType: "json",
                success: function(R) {
                    if (R.succeed) {
                        if (R.itemValues !== undefined) {
                            n(D, R.itemValues)
                        }
                        C(D, E);
                        v.reset(D.prop("id"));
                        var O = e("#btn-paging-entry-add,#btn-paging-entry-list,#btn-paging-entry-save,#button-excel-download"),
                            N = e("#btn-paging-entry-add-more,#btn-paging-entry-cancel,#paging-entry-form-wrap"),
                            Q, P;
                        if (E) {
                            e.merge(O, e("#btn-paging-entry-modify,#btn-paging-entry-download,#btn-paging-entry-delete"));
                            var M = e("#btn-paging-entry-restore");
                            e.merge(N, M);
                            Q = M;
                            P = q.succeedDelete || "Deleted"
                        } else {
                            e.merge(O, J);
                            e.merge(N, e("#btn-paging-entry-modify,#btn-paging-entry-delete,#btn-paging-entry-download"));
                            Q = e("#btn-paging-entry-modify");
                            P = q.succeedRestore || "Restored"
                        }
                        e(document.getElementById(q.listWrapId)).paginatedList("refresh");
                        O.css("display", "none");
                        N.css("display", "");
                        Q.noticepopup(P)
                    } else {
                        if (E) {
                            J.noticepopup(q.failDelete || "Fail to delete. Check please.")
                        } else {
                            J.noticepopup(q.failRestore || "Fail to restore. Check please.")
                        }
                    }
                }
            })
        });
        return false
    });
    e(document.body).on("click", "#btn-case-submit,#btn-case-submit-next,#btn-case-modify", function(N) {
        var T = e(N.currentTarget),
            D = document.getElementById("dropdown-case-product"),
            H = document.getElementById("dropdown-case-source-type"),
            E = document.getElementById("dropdown-case-source"),
            M = document.getElementById("case-source"),
            S = document.getElementById("case-subject"),
            G = document.getElementById("case-case"),
            J = E ? E.value : M.value,
            L = D ? D.value : undefined,
            V = H ? H.value : undefined,
            W = document.getElementById("form-case"),
            O = e(".case-entry-wrap:visible"),
            I = {
                page: O.attr("data-pagekey"),
                product: L,
                sourceType: V,
                source: J,
                subject: S.value || undefined,
                "case": G.value || undefined,
                followup: document.getElementById("case-followup").value || undefined
            };
        var K = O.find("._paging-form-wrap"),
            F;
        if (K.length > 0) {
            I["page-no"] = K.children('input[type="hidden"][name="case-paging-entry"]').val();
            if (/case-AE/i.test(O.prop("id"))) {
                if (K.is(":visible")) {
                    I.isMainAE = document.getElementById("AE_IS_MAIN").value == "M"
                }
                F = O
            } else {
                if (/composite/i.test(O.data("pagetype"))) {
                    F = O
                } else {
                    F = K
                }
            }
        } else {
            F = O
        }
        var P = function() {
            i(W.action, I, function(aw) {
                if (aw.succeed) {
                    if (aw.source !== null && aw.source !== undefined) {
                        M.value = aw.source
                    }
                    if (aw.subject !== null && aw.subject !== undefined) {
                        S.value = aw.subject
                    }
                    if (aw["case"] !== null && aw["case"] !== undefined) {
                        G.value = aw["case"]
                    }
                    var ag = e(".contents-navi");
                    ag.find(".page-box-disabled").removeClass("page-box-disabled");
                    ag.find(".page-box-on").removeClass("page-box-initial").addClass("page-box-saved");
                    O.attr("data-saved", "true");
                    var ac = "";
                    if (D && aw.product) {
                        document.getElementById("case-product").value = aw.productKey;
                        var ap = [],
                            X = "";
                        ap.push(z.replace(z.html.categoryItem, {
                            ID_ATTR: "",
                            LINK: "/product" + X,
                            STATUS: "off",
                            LABEL: aw.productLabel
                        }));
                        ap.push(z.replace(z.html.categoryItem, {
                            ID_ATTR: "",
                            LINK: "/product" + (X += ("/" + aw.product + "/" + aw.sourceType)),
                            STATUS: "off",
                            LABEL: aw.sourceTypeLabel
                        }));
                        ap.push(z.replace(z.html.categoryItem, {
                            ID_ATTR: "",
                            LINK: "/product" + (X += ("/" + aw.source)) + "/case",
                            STATUS: "off",
                            LABEL: aw.sourceLabel
                        }));
                        ap.push(z.replace(z.html.categoryItem, {
                            ID_ATTR: ' id="link-current-case"',
                            LINK: "/case" + X + "/" + aw["case"],
                            STATUS: "on",
                            LABEL: "CASE"
                        }));
                        ap.push('<div id="sub-navigation" class="top-navi-sub"></div>');
                        ac = "/case" + X + "/" + aw["case"];
                        document.getElementById("case-source-category").innerHTML = ap.join("");
                        document.getElementById("case-fu-product").value = aw.product;
                        document.getElementById("case-fu-sourceType").value = aw.sourceType;
                        document.getElementById("case-fu-source").value = aw.source;
                        document.getElementById("case-fu-case").value = aw["case"];
                        document.getElementById("case-cp-product").value = aw.product;
                        document.getElementById("case-cp-sourceType").value = aw.sourceType;
                        document.getElementById("case-cp-source").value = aw.source;
                        document.getElementById("case-cp-case").value = aw["case"]
                    } else {
                        var ar = /\/case\/[^/]+\/[^/]+\/\d+$/i;
                        e("#case-source-category").find("a:has(div.top-navi-on)").each(function(ay, az) {
                            var ax = e(az).attr("href");
                            if (ar.test(ax)) {
                                az.href = ax + "/" + aw["case"];
                                ac = ax + "/" + aw["case"]
                            }
                        });
                        document.getElementById("case-fu-case").value = aw["case"];
                        document.getElementById("case-cp-case").value = aw["case"]
                    }
                    var Z = document.getElementById("sub-navigation");
                    if (Z) {
                        var ab = e(Z),
                            Y = ab.find("a");
                        if (Y.length == 0) {
                            ab.append('<a href="' + ac + '"><span class="current">' + q["case"]["initialTitle"] + "</span></a>")
                        }
                    }
                    if (T.is("#btn-case-submit-next")) {
                        e(document.body).detectchanged("disabled");
                        var aj = e(".case-page-wrap1:has(.page-box-on)").next().find("a"),
                            ad = document.getElementById("link-current-case"),
                            al = aj.data("pageid");
                        if (ad && al) {
                            location.href = ad.pathname + (al.toLowerCase ? "-" + al.toLowerCase() : "")
                        } else {
                            aj.trigger("click")
                        }
                    } else {
                        T.noticepopup(q.succeedSave || "Saved");
                        var ao = e.merge(e("#bottom-wrap").find("a"), e("#case-deleted-alert")),
                            aq = e("#btn-case-modify");
                        if (K.is("._paging-form-wrap")) {
                            if (aw.pageEntry) {
                                K.children('input[type="hidden"][name="case-paging-entry"]').val(aw.pageEntry);
                                K.children("div.case-item-title").find("._paging_no").html("No." + aw.pageEntry)
                            }
                            w(O, aw.itemValues);
                            if (K.is(":visible")) {
                                e.merge(aq, e("#btn-case-cancel,#btn-case-page-delete,#btn-case-add-more"))
                            } else {
                                e.merge(aq, e("#btn-case-add-more"))
                            }
                        }
                        K.find(".item-group-icon,.item-icon").find('a.a-disabled:has(img[data-role^="more-"])').removeClass("a-disabled").find("img").prop("src", "/resources/image/more-on.png");
                        if (O.is('[data-pageindex="0"]')) {
                            e.merge(aq, e("#btn-case-delete,#btn-case-export"));
                            if (Z && e(Z).find("span").last().is(".current")) {
                                e.merge(aq, e("#btn-case-followup,#btn-case-copy-subject"))
                            }
                        }
                        ao.not(aq).css("display", "none");
                        aq.css("display", "");
                        var at = document.getElementById("SUBJ_CODE");
                        if (at && aw.itemValues) {
                            var ai = e(at).data("itemkey");
                            for (var ak = 0, am = aw.itemValues.length; ak < am; ak++) {
                                if (ai == aw.itemValues[ak]["ITEM_KEY"]) {
                                    at.value = aw.itemValues[ak]["VALUE"];
                                    break
                                }
                            }
                        }
                        var ae = document.getElementById("IS_MNFT_REPORT"),
                            an = document.getElementById("IS_MNFT_DUE"),
                            af = document.getElementById("mnft-is-report"),
                            ah = document.getElementById("mnft-due-date");
                        if (ae && an && af && ah) {
                            af.value = ae.value;
                            ah.value = an.value
                        }
                        e.entryChecker();
                        e.pagingFormChecker();
                        var av = e("#relation_suspect_change");
                        if (av !== undefined && av.length > 0 && av.val() === "true") {
                            e("#relation_suspect_change").val("false")
                        }
                        e('.case-status a:has(img[data-statustype="review"])').prop("className", "").children("img").prop("src", "/resources/image/status-review-off.png")
                    }
                } else {
                    if (aw.exception) {
                        if (aw.noticeType == "warn") {
                            var aa = {};
                            aa[(q.confirm || "Saved")] = function() {
                                if (aw["force-code"]) {
                                    I["force-code"] = aw["force-code"]
                                }
                                if (aw.param) {
                                    I[aw.param] = "true"
                                } else {
                                    I.isMainAE = undefined
                                }
                                P();
                                T.popoverdialog("close")
                            };
                            aa[(q.cancel || "Cancel")] = function() {
                                T.popoverdialog("close")
                            };
                            T.popoverdialog({
                                title: aw.exception,
                                buttons: aa
                            })
                        } else {
                            var au = {};
                            au[(q.cancel || "Cancel")] = function() {
                                T.popoverdialog("close")
                            };
                            T.popoverdialog({
                                title: aw.exception,
                                buttons: au
                            })
                        }
                    } else {
                        T.errorpopup(q.failSave || "Fail to save. Check please.")
                    }
                }
            }, F)
        };
        var R = function() {
            if (T.is("#btn-case-modify")) {
                h(T, function(X) {
                    I.reason = X;
                    P()
                })
            } else {
                P()
            }
        };
        var U = e("#relation_suspect_change");
        if (U !== undefined && U.length > 0 && U.val() === "true") {
            var Q = {};
            Q[(q.changeConfirm || "Confirmed")] = function() {
                e.popoverdialog("close");
                R();
                return false
            };
            Q[(q.cancel || "Cancel")] = function() {
                e.popoverdialog("close")
            };
            T.popoverdialog({
                title: q.relationSuspectChangeConfirm || "Are you sure to change relatedness of suspect medication?",
                width: 300,
                content: "",
                buttons: Q
            })
        } else {
            R()
        }
        return false
    });
    e(document.body).on("click", "#btn-case-delete,#btn-case-restore", function(G) {
        var J = e(G.currentTarget),
            D = e(".case-entry-wrap:visible"),
            E = J.is("#btn-case-delete"),
            F = document.getElementById("form-case"),
            I = document.getElementById("case-case"),
            H = document.getElementById("case-status");
        x(J, E, function(L) {
            var K = F.action.replace(/\/submit$/i, ("/" + (E ? "delete" : "restore") + ".json"));
            e.ajax({
                url: K,
                method: "POST",
                data: {
                    entry: I.value,
                    reason: L
                },
                dataType: "json",
                success: function(R) {
                    if (R.succeed) {
                        C(D, E);
                        var O = e.merge(e("#bottom-wrap").find("a"), e("#case-deleted-alert")),
                            N, Q, P;
                        if (E) {
                            var M = e(document.getElementById("btn-case-restore"));
                            N = M;
                            Q = M;
                            P = q.succeedDelete || "Deleted";
                            H.value = "deleted"
                        } else {
                            N = e("#btn-case-modify,#btn-case-delete,#btn-case-export,#btn-case-followup,#btn-case-copy-subject");
                            Q = e("#btn-case-modify");
                            P = q.succeedRestore || "Restored";
                            H.value = "restored"
                        }
                        O.not(N).css("display", "none");
                        N.css("display", "");
                        Q.noticepopup(P)
                    } else {
                        if (E) {
                            J.noticepopup(q.failDelete || "Fail to delete. Check please.")
                        } else {
                            J.noticepopup(q.failRestore || "Fail to restore. Check please.")
                        }
                    }
                }
            })
        });
        return false
    });

    function g(E) {
        var G = e(E);
        var D = document.getElementById("case-case").value;
        if (D.length > 0) {
            var H = G.data("statustype").toUpperCase(),
                F = (G.parent("a").prop("className") === "on") ? "N" : "Y";
            e.ajax({
                type: "POST",
                url: "/case/change-status",
                data: {
                    "case": D,
                    supplyId: H,
                    value: F
                },
                success: function(I) {
                    location.reload()
                },
                dataType: "json",
                hideLoading: true
            })
        }
    }
    e(document.body).on("click", ".case-status img.privilege", function(D) {
        g(D.currentTarget);
        return false
    });

    function b(K) {
        var D = e(K);
        if (D.find(".page-box-disabled").length > 0) {
            return false
        }
        var E = document.getElementById("case-case").value;
        if (E.length > 0) {
            var M = document.getElementById("link-current-case"),
                H = D.data("pageid");
            if (M && H) {
                var F = M.pathname;
                if (!(/^\//.test(F) || /^http(s)?/i.test(F))) {
                    F = "/" + F
                }
                if (/BASE_INFO/i.test(H)) {
                    location.href = F
                } else {
                    location.href = F + "-" + (H.toLowerCase ? H.toLowerCase() : H)
                }
            } else {
                var N = document.getElementById("case-product-code"),
                    G = document.getElementById("case-source"),
                    R = document.getElementById("case-status"),
                    P = e("#case-" + D.attr("data-pageid")),
                    J = e(".case-entry-wrap:visible"),
                    I = P.find("._paging-form-wrap"),
                    Q = D.closest(".contents-navi").find(".case-page-box"),
                    O = D.find(".case-page-box"),
                    L = Q.not(O);
                L.removeClass("page-box-on").addClass("page-box-off");
                O.removeClass("page-box-off").addClass("page-box-on");
                e.ajax({
                    url: "/case/load.json",
                    data: {
                        source: G.value,
                        "case": E,
                        page: P.attr("data-pagekey")
                    },
                    method: "POST",
                    dataType: "json",
                    success: function(U) {
                        var T = U.caseDeleted,
                            V = U.itemValues,
                            S = P.is('[data-saved="true"]');
                        R.value = (T ? "deleted" : "restored");
                        if (V.length > 0) {
                            if (!S) {
                                P.attr("data-saved", "true");
                                O.removeClass("page-box-initial").addClass("page-box-saved")
                            }
                            if (I.length > 0) {
                                w(P, V)
                            } else {
                                n(P, V)
                            }
                        }
                    },
                    complete: function() {
                        var W = e.merge(e("#bottom-wrap").find("a"), e("#case-deleted-alert")),
                            S = e(".case-page-wrap1 a:first").is(D),
                            U, V, T;
                        if (R.value == "deleted") {
                            if (S) {
                                U = e("#btn-case-restore")
                            } else {
                                U = e("#case-deleted-alert")
                            }
                        } else {
                            if (I.length > 0) {
                                V = P.find(".item-table-wrap table tbody tr").not(".tr-nodata").length;
                                if (V > 0) {
                                    if (/composite/i.test(P.data("pagetype"))) {
                                        U = e("#btn-case-modify,#btn-case-add-more")
                                    } else {
                                        U = e("#btn-case-add")
                                    }
                                } else {
                                    U = e("#btn-case-submit,#btn-case-submit-next")
                                }
                            } else {
                                if (P.is('[data-saved="true"]')) {
                                    if (S) {
                                        U = e("#btn-case-modify,#btn-case-delete,#btn-case-export,#btn-case-followup,#btn-case-copy-subject")
                                    } else {
                                        U = e("#btn-case-modify")
                                    }
                                    T = true
                                } else {
                                    if (e(".case-page-wrap1 a:last").is(D)) {
                                        U = e("#btn-case-submit")
                                    } else {
                                        U = e("#btn-case-submit,#btn-case-submit-next")
                                    }
                                    T = false
                                }
                            }
                        }
                        W.not(U).css("display", "none");
                        U.css("display", "");
                        if (T !== undefined) {
                            if (T) {
                                P.find(".item-group-icon,.item-icon").find('a.a-disabled:has(img[data-role^="more-"])').removeClass("a-disabled").find("img").prop("src", "/resources/image/more-on.png")
                            } else {
                                P.find(".item-group-icon,.item-icon").find("a").not(".a-disabled").filter(':has(img[data-role^="more-"])').addClass("a-disabled").find("img").prop("src", "/resources/image/more-off.png")
                            }
                        }
                        if (I.length > 0 && (V === undefined || V > 0)) {
                            I.css("display", "none");
                            P.css("border-bottom", "none")
                        } else {
                            I.css("display", "");
                            P.css("border-bottom", "")
                        }
                        C(P, (R.value == "deleted"));
                        v.reset(P.prop("id"));
                        J.css("display", "none");
                        P.css("display", "")
                    }
                })
            }
        }
    }
    e(document.body).on("click", ".case-page-wrap1 a", function(D) {
        b(D.currentTarget);
        return false
    });
    e(document.body).on("click", ".case-entry-wrap .item-table-wrap tbody tr:not(.tr-nodata)", function(F) {
        if (e("._paging-form-wrap").is(":visible") && e("._paging-form-wrap").detectchanged()) {
            if (!confirm(q.confirmWithoutSave || "Move to another page without saving?")) {
                return false
            }
        }
        var D = e(F.currentTarget),
            K = D.closest(".case-entry-wrap"),
            I = K.find("._paging-form-wrap"),
            G = document.getElementById("case-source"),
            M = document.getElementById("case-status"),
            J = document.getElementById("case-case"),
            E = K.attr("data-pagekey"),
            L = D.attr("data-pageno"),
            H = "/case/load.json";
        e.ajax({
            url: H,
            data: {
                source: G.value,
                "case": J.value,
                page: E,
                entry: L
            },
            method: "POST",
            dataType: "json",
            success: function(U) {
                var R = U.caseDeleted,
                    Q = U.pageDeleted,
                    T = U.caseLocked,
                    P = I,
                    O = U.itemValues,
                    S = e.merge(e("#bottom-wrap").find("a"), e("#case-deleted-alert")),
                    N;
                M.value = (R ? "deleted" : "restored");
                I.children("div.case-item-title").find("._paging_no").html("No." + L);
                n(P, O);
                v.reset(K.prop("id"));
                I.children('input[type="hidden"][name="case-paging-entry"]').val(L);
                K.css("border-bottom", "");
                I.find(".item-group-icon,.item-icon").find('a.a-disabled:has(img[data-role^="more-"])').removeClass("a-disabled").find("img").prop("src", "/resources/image/more-on.png");
                if (R) {
                    N = e("#btn-case-cancel,#case-deleted-alert")
                } else {
                    if (Q) {
                        N = e("#btn-case-add-more,#btn-case-cancel,#btn-case-page-restore")
                    } else {
                        N = e("#btn-case-add-more,#btn-case-modify,#btn-case-cancel,#btn-case-page-delete")
                    }
                }
                S.not(N).css("display", "none");
                N.css("display", "");
                if (T) {
                    if (R || (Q !== undefined && Q)) {
                        C(K, R, Q, L)
                    }
                    e("input:checkbox").prop("disabled", true)
                } else {
                    C(K, R, Q, L)
                }
                I.css("display", "");
                e("._paging-form-wrap").detectchanged("init")
            }
        });
        return false
    });
    e(document.body).on("click", "#btn-case-cancel", function() {
        var H = e(".case-entry-wrap:visible"),
            D = H.find("._paging-form-wrap"),
            G = document.getElementById("case-status"),
            F = e.merge(e("#bottom-wrap").find("a"), e("#case-deleted-alert")),
            E;
        H.css("border-bottom", "none");
        D.css("display", "none");
        if (G.value != "deleted") {
            if (/composite/i.test(H.data("pagetype"))) {
                E = e("#btn-case-modify,#btn-case-add-more")
            } else {
                E = e("#btn-case-add")
            }
        }
        if (/case-AE/i.test(H.prop("id"))) {
            e.merge(E, e("#btn-case-export"))
        }
        if (E) {
            F.not(E).css("display", "none");
            E.css("display", "")
        } else {
            F.css("display", "none")
        }
        o(D);
        return false
    });
    e(document.body).on("click", "#btn-case-add,#btn-case-add-more", function() {
        var H = e(".case-entry-wrap:visible"),
            K = H.find("._paging-form-wrap"),
            E = H.find(".item-table-wrap table tbody tr:not(.tr-nodata)").length + 1,
            L = e.merge(e("#bottom-wrap").find("a"), e("#case-deleted-alert")),
            F = e("#btn-case-submit,#btn-case-submit-next,#btn-case-cancel,._paging-form-wrap");
        if (e("._paging-form-wrap").is(":visible") && e("._paging-form-wrap").detectchanged()) {
            if (!confirm(q.confirmWithoutSave || "Move to another page without saving?")) {
                return false
            }
        }
        K.children("div.case-item-title").find("._paging_no").html("No." + E);
        o(K);
        v.reset(H.prop("id"));
        H.css("border-bottom", "");
        C(H, false, false);
        K.find(".item-group-icon,.item-icon").find("a").not(".a-disabled").filter(':has(img[data-role^="more-"])').addClass("a-disabled").find("img").prop("src", "/resources/image/more-off.png");
        L.not(F).css("display", "none");
        F.css("display", "");
        K.children('input[type="hidden"][name="case-paging-entry"]').val("-1");
        e.ajax({
            type: "POST",
            url: "/case/default-medcode-version",
            data: {
                source: document.getElementById("case-source").value
            },
            success: function(N) {
                var M = N.medicalCodingDefaultVersionMap;
                if (M != undefined) {
                    e.each(M, function(O, P) {
                        e('[id$="' + O + '_VER"]').val(P).trigger("change")
                    })
                }
                e("._paging-form-wrap").detectchanged("init")
            },
            dataType: "json",
            hideLoading: true
        });
        var I = document.getElementById("case-AE");
        if (I && e(I).attr("data-saved") == "true") {
            var G = document.getElementsByName("AE_IS_MAIN-r");
            for (var D = 0, J = G.length; D < J; D++) {
                if (G[D].value == "S") {
                    G[D].checked = true;
                    document.getElementById("AE_IS_MAIN").value = "S";
                    break
                }
            }
        }
        return false
    });
    e(document.body).on("click", "#btn-case-page-delete,#btn-case-page-restore", function(G) {
        var I = e(G.currentTarget),
            H = document.getElementById("case-case"),
            J = e(".case-entry-wrap:visible"),
            D = J.find("._paging-form-wrap"),
            E = I.is("#btn-case-page-delete");
        if (/case-AE/i.test(J.prop("id"))) {
            var F = document.getElementById("AE_IS_MAIN");
            if (F.value == "M") {
                I.noticepopup(q["case.highlightEventDeleteFail"] || "Highlighted adverse events can not be deleted. Check please.");
                return
            }
        }
        x(I, E, function(K) {
            e.ajax({
                url: "/case/page-" + (E ? "delete" : "restore") + ".json",
                method: "POST",
                data: {
                    subject: document.getElementById("case-subject").value,
                    source: document.getElementById("case-source").value,
                    followup: document.getElementById("case-followup").value,
                    page: J.attr("data-pagekey"),
                    "case": H.value,
                    entry: D.children('input[type="hidden"][name="case-paging-entry"]').val(),
                    reason: K
                },
                dataType: "json",
                success: function(P) {
                    if (P.succeed) {
                        C(D, E);
                        var M = e.merge(e("#bottom-wrap").find("a"), e("#case-deleted-alert")),
                            L, O, N;
                        if (E) {
                            L = e("#btn-case-add-more,#btn-case-cancel,#btn-case-page-restore");
                            O = e("#btn-case-page-restore");
                            N = q.succeedDelete || "Deleted"
                        } else {
                            L = e("#btn-case-add-more,#btn-case-modify,#btn-case-cancel,#btn-case-page-delete");
                            O = e("#btn-case-modify");
                            N = q.succeedRestore || "Restored"
                        }
                        M.not(L).css("display", "none");
                        L.css("display", "");
                        w(J, P.itemValues);
                        O.noticepopup(N)
                    } else {
                        if (E) {
                            I.noticepopup(q.failDelete || "Fail to delete. Check please.")
                        } else {
                            I.noticepopup(q.failRestore || "Fail to restore. Check please.")
                        }
                    }
                }
            })
        });
        return false
    });
    e(document.body).on("click", "#btn-case-followup", function() {
        e(document.getElementById("case-followup-form")).submit()
    });
    e(document.body).on("click", "#btn-case-copy-subject", function() {
        e(document.getElementById("case-copy-form")).submit()
    });
    e(document.body).on("click", "#btn-case-export", function(D) {
        var E = e(D.currentTarget),
            H = e("#case-export-popover"),
            K = H.prop("title"),
            M = H.find("li"),
            F = '<div><label><input type="radio" name="case-export-type" value="#{VALUE}#" data-ver="#{VERSION}#"/> #{LABEL}#</label></div>',
            O = [];
        for (var G = 0, N = M.length; G < N; G++) {
            var L = M.eq(G),
                J = L.html();
            O.push(z.replace(F, {
                VALUE: L.attr("data-id"),
                LABEL: J,
                VERSION: L.attr("data-ver")
            }))
        }
        var I = {};
        I[(q.confirm || "Saved")] = function() {
            var R = e(document.getElementsByName("case-export-type")).filter(function() {
                return this.checked
            });
            if (R.length == 0) {
                return
            }
            var Q = ['<input type="hidden" name="product" value="' + document.getElementById("case-product").value + '"/>', '<input type="hidden" name="source" value="' + document.getElementById("case-source").value + '"/>', '<input type="hidden" name="case" value="' + document.getElementById("case-case").value + '"/>', '<input type="hidden" name="form" value="' + R.prop("value") + '"/>', '<input type="hidden" name="version" value="' + R.attr("data-ver") + '"/>'];
            if (R.prop("value") === "ICH_ICSR_XML") {
                var P = false;
                e.ajax({
                    type: "POST",
                    url: "/case/check-saved-relation",
                    data: {
                        "case": document.getElementById("case-case").value
                    },
                    async: false,
                    success: function(S) {
                        P = S.existsSavedReleation
                    }
                });
                if (P !== true) {
                    e.popoverdialog("close");
                    E.noticepopup(q.relationNotSaved || "Relation is not saved.");
                    return false
                }
            }
            m("/case/export", Q);
            e.popoverdialog("close")
        };
        I[(q.cancel || "Cancel")] = function() {
            e.popoverdialog("close")
        };
        E.popoverdialog({
            title: K,
            width: 300,
            content: '<div class="layer-contents">' + O.join("") + "</div>",
            buttons: I
        });
        return false
    });

    function f() {
        var E = document.getElementById("dropdown-case-product").value,
            D = document.getElementById("dropdown-case-source-type").value,
            F = e("#dropdown-case-source");
        F.find("option").not('[data-type="notselect"]').remove();
        if (E && D) {
            e.ajax({
                type: "POST",
                url: "/case/load-sources.json",
                data: {
                    product: E,
                    sourceType: D
                },
                success: function(K) {
                    if (K.options) {
                        var H = [];
                        for (var J = 0, I = K.options.length; J < I; J++) {
                            var G = K.options[J];
                            H.push(z.replace(z.html.defaultOption, {
                                VALUE: G.value,
                                LABEL: G.label
                            }))
                        }
                        F.append(H.join(""))
                    }
                },
                dataType: "json"
            })
        }
    }
    e(document.body).on("change", "#dropdown-case-product", function(E) {
        var D = E.target.value;
        if (D == "") {
            e("#dropdown-case-source-type").find('option[data-type="notselect"]:eq(0)').prop("selected", true)
        }
        f()
    });
    e(document.body).on("change", "#dropdown-case-source-type", function() {
        f()
    });
    e(document.body).on("change", "#dropdown-case-source", function(F) {
        var D = F.currentTarget,
            E = document.getElementById("dropdown-case-source-type"),
            G = document.getElementById("case-sourceType");
        if (G) {
            G.value = E.value
        }
        if (!/^spontaneous$/i.test(E.value)) {
            return
        }
        e.ajax({
            type: "POST",
            url: "/case/load-subject-base.json",
            data: {
                source: D.value,
                sourceType: E.value
            },
            success: function(L) {
                if (L.spontaneousSubject) {
                    var M = L.spontaneousSubject;
                    var P = document.getElementById("SUBJ_INIT"),
                        S = document.getElementById("SUBJ_SEX"),
                        Q = document.getElementsByName("SUBJ_SEX-r"),
                        U = document.getElementById("AGE"),
                        N = document.getElementById("AGE_TYPE"),
                        W = document.getElementsByName("AGE_TYPE-r"),
                        R = document.getElementById("OTHER_AGE"),
                        K = document.getElementById("OTHER_AGE_UNIT"),
                        T = document.getElementsByName("OTHER_AGE_UNIT-r");
                    if (P && M.initial) {
                        P.value = M.initial
                    }
                    var O;
                    if (S && M.gender) {
                        O = M.gender
                    }
                    S.value = O;
                    for (var H = 0, J = Q.length; H < J; H++) {
                        if (Q[H].value == O) {
                            Q[H].checked = true;
                            break
                        }
                    }
                    if (U && M.age) {
                        U.value = M.age
                    }
                    var I;
                    if (N && M.ageType) {
                        I = M.ageType
                    } else {
                        I = ""
                    }
                    N.value = I;
                    for (var H = 0, J = W.length; H < J; H++) {
                        if (W[H].value == I) {
                            W[H].checked = true;
                            break
                        }
                    }
                    if (R && M.ageOther) {
                        R.value = M.ageOther
                    }
                    var V;
                    if (K && M.ageOtherUnit) {
                        V = M.ageOtherUnit
                    } else {
                        V = ""
                    }
                    K.value = V;
                    for (var H = 0, J = T.length; H < J; H++) {
                        if (T[H].value == V) {
                            T[H].checked = true;
                            break
                        }
                    }
                    v.manual.call(this, e(G))
                }
            },
            dataType: "json"
        })
    });
    e(document.body).on("click", 'a:has(img[data-role="english-group"])', function(E) {
        var F = e(E.currentTarget);
        if (F.is(".a-disabled")) {
            return false
        }
        var D = e(E.currentTarget).closest(".item-group-icon-wrap").prev();
        k(F, D);
        return false
    });
    e(document.body).on("click", 'a:has(img[data-role="english-item"])', function(E) {
        var F = e(E.currentTarget);
        if (F.is(".a-disabled")) {
            return false
        }
        var D = e(E.currentTarget).closest(".item-icon-wrap").prev();
        k(F, D);
        return false
    });
    e(document.body).on("click", 'a:has(img[data-role="clear-group"])', function(E) {
        var F = e(E.currentTarget);
        if (F.is(".a-disabled")) {
            return false
        }
        var D = F.closest(".item-group-icon-wrap").prev();
        o(D, true);
        v.manual(D.find("input,select,textarea").filter("[data-itemkey]"));
        return false
    });
    e(document.body).on("click", 'a:has(img[data-role="clear-item"])', function(E) {
        var F = e(E.currentTarget);
        if (F.is(".a-disabled")) {
            return false
        }
        var D = F.closest(".item-icon-wrap").prev();
        o(D, true);
        v.manual(D.find("input,select,textarea").filter("[data-itemkey]"));
        return false
    });
    e(document.body).on("click", 'a:has(img[data-role="more-group"])', function(E) {
        var F = e(E.currentTarget);
        if (F.is(".a-disabled")) {
            return false
        }
        var D = e(E.currentTarget).closest(".item-group-icon-wrap").prev();
        j(D, F);
        return false
    });
    e(document.body).on("click", 'a:has(img[data-role="more-item"])', function(E) {
        var F = e(E.currentTarget);
        if (F.is(".a-disabled")) {
            return false
        }
        var D = e(E.currentTarget).closest(".item-icon-wrap").prev();
        j(D, F);
        return false
    });
    e(document.body).on("click", "#btn-customized-submit,#btn-customized-modify", function(G) {
        var I = e(G.currentTarget),
            F = document.getElementById("form-customized"),
            H = {
                page: document.getElementById("customized-page").value
            },
            E = F.action,
            D = function() {
                i(E, H, function(J) {
                    if (J.succeed) {
                        I.noticepopup(q.succeedSave || "Saved");
                        e("#btn-customized-submit").css("display", "none");
                        e("#btn-customized-modify,#btn-customized-delete").css("display", "");
                        if (J.entry) {
                            F.action = F.action.replace(/\d+$/i, J.entry);
                            document.getElementById("customized-label").innerHTML = "Edit";
                            e("#sub-navigation").find("a").each(function(K, L) {
                                L.href = e(L).attr("href").replace(/(\/misc\/[^/]+\/)[^/]+/gi, "$1" + J.entry)
                            });
                            e(".item-group-icon,.item-icon").find('a.a-disabled:has(img[data-role^="more-"])').removeClass("a-disabled").find("img").prop("src", "/resources/image/more-on.png")
                        }
                    } else {
                        I.errorpopup(q.failSave || "Fail to save. Check please.")
                    }
                })
            };
        if (I.is("#btn-customized-modify")) {
            h(I, function(J) {
                H.reason = J;
                D()
            })
        } else {
            D()
        }
        return false
    });
    e(document.body).on("click", "#btn-customized-delete,#btn-customized-restore", function(G) {
        var H = e(G.currentTarget),
            D = e(".case-entry-wrap"),
            E = H.is("#btn-customized-delete"),
            F = document.getElementById("form-customized");
        x(H, E, function(J) {
            var I = F.action + "/" + (E ? "delete" : "restore") + ".json";
            e.ajax({
                url: I,
                method: "POST",
                data: {
                    reason: J
                },
                dataType: "json",
                success: function(O) {
                    if (O.succeed) {
                        C(D, E);
                        var L = e("#bottom-wrap").find("a"),
                            K = e("#btn-customized-list"),
                            N, M;
                        if (E) {
                            N = e("#btn-customized-restore");
                            M = q.succeedDelete || "Deleted";
                            e.merge(K, N)
                        } else {
                            N = e("#btn-customized-modify");
                            M = q.succeedRestore || "Restored";
                            e.merge(e.merge(K, N), e("#btn-customized-delete"))
                        }
                        L.not(K).css("display", "none");
                        K.css("display", "");
                        N.noticepopup(M)
                    } else {
                        if (E) {
                            H.noticepopup(q.failDelete || "Fail to delete. Check please.")
                        } else {
                            H.noticepopup(q.failRestore || "Fail to restore. Check please.")
                        }
                    }
                }
            })
        });
        return false
    });
    e(document.body).on("click", "#btn-page-data-export", function(D) {
        var E = e(D.currentTarget);
        m(E.attr("data-source"));
        return false
    });
    e(document.body).on("click", "#btn-kids-export", function() {
        var J = document.getElementById("form-kids-product"),
            K = document.getElementById("FORM_KIDS_BEGIN_DATE"),
            E = document.getElementById("FORM_KIDS_END_DATE"),
            D = document.getElementsByName("period-type"),
            I = document.getElementsByName("case-type"),
            N = document.getElementsByName("source-type");
        if (J.value.length == 0) {
            alert(q.form["required.product"] || "Please select product.");
            return false
        }
        if (K.value.length == 0 || E.value.length == 0) {
            alert(q.form["required.period"] || "Please select period.");
            return false
        }
        var G = ['<input type="hidden" name="start" value="' + K.value + '"/>', '<input type="hidden" name="end" value="' + E.value + '"/>', '<input type="hidden" name="product" value="' + J.value + '"/>'];
        for (var F = 0, L = D.length; F < L; F++) {
            if (D[F].checked) {
                G.push('<input type="hidden" name="period-type" value="' + D[F].value + '"/>');
                break
            }
        }
        for (var M = 0, O = I.length; M < O; M++) {
            if (I[M].checked) {
                G.push('<input type="hidden" name="case-type" value="' + I[M].value + '"/>');
                break
            }
        }
        for (var P = 0, H = N.length; P < H; P++) {
            if (N[P].checked) {
                G.push('<input type="hidden" name="source-type" value="' + N[P].value + '"/>');
                break
            }
        }
        m("/form/export.xls", G);
        return false
    });
    e(document.body).ready(function() {
        var O = location.hash;
        if (O.length > 1) {
            var I = document.getElementById("case-navi-" + O.substr(1).toLowerCase());
            if (I) {
                b(I)
            }
        }
        var ac = e(".case-entry-wrap"),
            ab = ac.filter(":visible");
        for (var U = 0, ad = ac.length; U < ad; U++) {
            v.bindTriggerEvent(ac.eq(U).prop("id"))
        }
        if (ab.length == 1) {
            v.reset(ab.prop("id"))
        }
        if (q !== undefined && q.listWrapId) {
            var D = document.getElementById(q.listWrapId);
            if (D) {
                var L = e(D);
                L.paginatedList({
                    tableWrapClassName: "contents-detail",
                    tableClassName: "test-table",
                    countable: true,
                    editable: false,
                    countCellWidthRate: "6%",
                    columns: q.paginatedColumns["headers"],
                    paginatedListProperty: q.paginatedColumns["property"],
                    initContent: q.initializeContent,
                    initPageIndex: q.initPageIndex,
                    loaderURL: q.paginatedDataURL,
                    rowNum: q.initRowCount,
                    extraParam: q.paginatedDataParam
                });
                L.on("rowEdit.paginatedList cellClick.paginatedList", q.paginatedClickHandler)
            }
            var P = document.getElementById("button-excel-download");
            if (P && q.excelURL) {
                e(P).on("click", function() {
                    m(q.excelURL);
                    return false
                })
            }
        }
        var M = {};
        var R = e("select").filter('[data-type="dynamic"]'),
            G = function(ak, ai, aj) {
                var al = function() {
                    var aq = {},
                        ap = ak.attr("data-origin");
                    if (aj) {
                        var ar = e(aj);
                        for (var au = 0, an = ar.length; au < an; au++) {
                            var av = ar.eq(au);
                            if (av.prop("name") && av.prop("value")) {
                                aq[av.prop("name")] = av.prop("value")
                            }
                        }
                    }
                    var at = function(ax) {
                            var aC = [],
                                aE = false;
                            if (ax.options) {
                                for (var aw = 0, az = ax.options.length; aw < az; aw++) {
                                    var aB = ax.options[aw],
                                        aA;
                                    if (typeof aB == "object") {
                                        if (aB.label) {
                                            aA = aB.label;
                                            aB = aB.value
                                        } else {
                                            aB = aA = aB.value
                                        }
                                    }
                                    var aD = z.html.defaultOption;
                                    if (ap == aB) {
                                        aE = true;
                                        aD = z.html.selectedOption
                                    }
                                    aC.push(z.replace(aD, {
                                        LABEL: aA,
                                        VALUE: aB
                                    }))
                                }
                            }
                            var ay = "";
                            if (!aE && ap.length > 0) {
                                ay = z.replace(z.html.selectedOption, {
                                    LABEL: ap,
                                    VALUE: ap
                                }) + aC.join("")
                            } else {
                                ay = aC.join("")
                            }
                            ak.find("option:gt(0)").remove();
                            ak.append(ay)
                        },
                        ao = e.isEmptyObject(aq),
                        am = ak.prop("name").replace(/^.+_([^_]+)_VER$/i, "$1");
                    if (ao && M[am]) {
                        at(M[am])
                    } else {
                        e.ajax({
                            url: "/entry/load-options.json",
                            method: "POST",
                            dataType: "json",
                            data: e.extend({
                                target: ak.prop("name")
                            }, aq),
                            hideLoading: true,
                            success: function(aw) {
                                at(aw);
                                if (ao) {
                                    M[am] = aw
                                }
                            }
                        })
                    }
                };
                al();
                if (ai) {
                    e(document.body).on("change", ai, al)
                }
            };
        var V = 0,
            X = 100;
        for (var W = 0, T = R.length; W < T; W++) {
            var K = R.eq(W),
                aa = K.prop("name");
            if (aa == "SITE_CODE") {
                G(K, "#dropdown-case-product,#dropdown-case-source-type,#dropdown-case-source", "#dropdown-case-source,#case-source")
            } else {
                if (V == 0) {
                    X = 1
                } else {
                    if (X < 100) {
                        X = 100
                    }
                    X += Math.round(100 / Math.pow(2, V - 1))
                }
                V++;
                setTimeout(function() {
                    G(K)
                }, X)
            }
        }
        var ah = document.getElementById("case-AE");
        if (ah && e(ah).attr("data-saved") == "false") {
            var E = document.getElementsByName("AE_IS_MAIN-r");
            for (var S = 0, F = E.length; S < F; S++) {
                if (E[S].value == "M") {
                    E[S].checked = true;
                    document.getElementById("AE_IS_MAIN").value = "M";
                    break
                }
            }
        }
        if (document.getElementById("privilege-edit")) {
            var Q = e(document.getElementById("privilege-all"));
            var ag = e(document.getElementById("privileges-wrap")).find("input").filter(function() {
                return this.name == "privilege"
            });
            Q.on("click", function() {
                ag.prop("checked", Q.prop("checked"))
            });
            ag.on("click", function() {
                var ai = ag.filter(function() {
                    return this.checked
                }).length;
                Q.prop("checked", ai == ag.length)
            });
            e(document.body).on("click", "#btn-role-modify", function(aj) {
                var ar = e(aj.currentTarget),
                    aq = document.getElementById("form-role"),
                    ao = aq.action,
                    am = e(".case-entry-wrap"),
                    at = document.getElementById("ROLE_ALIAS"),
                    ak = {
                        role: document.getElementById("role-key").value
                    };
                if (at) {
                    ak.name = e.trim(at.value)
                }
                var al = [];
                for (var an = 0, ap = ag.length; an < ap; an++) {
                    if (ag[an].checked) {
                        al.push(ag[an].value)
                    }
                }
                ak.privileges = al;
                var ai = function() {
                    i(ao, ak, function(au) {
                        if (au.succeed) {
                            ar.noticepopup(q.succeedSave || "Saved");
                            if (au.role) {
                                document.getElementById("role-label").innerHTML = au.role
                            }
                        } else {
                            ar.errorpopup(q.failSave || "Fail to save. Check please.")
                        }
                    }, am)
                };
                h(ar, function(au) {
                    ak.reason = au;
                    ai()
                });
                return false
            })
        }
        if (document.getElementById("import-upload")) {
            var Z = window.location.pathname.split("/"),
                H = (e.isArray(Z) && Z.length > 2) ? Z[2] : undefined;
            e(document.body).on("change", "#dropdown-import-product", function(aj) {
                var ai = aj.target.value;
                if (ai == "") {
                    e("#dropdown-import-source-type").find('option[data-type="notselect"]:eq(0)').prop("selected", true)
                }
                Y()
            });
            e(document.body).on("change", "#dropdown-import-source-type", function() {
                Y()
            });
            af(e('input[name="fileImport"]'));
            if (H != undefined) {
                var N = ae(H);
                if (N === "INITIAL" || N === "RUN") {
                    var J = setInterval(function() {
                        N = ae(H);
                        if (N !== "INITIAL" && N !== "RUN") {
                            clearInterval(J)
                        }
                    }, 5000)
                }
            }

            function Y() {
                var ak = document.getElementById("dropdown-import-product").value,
                    aj = document.getElementById("dropdown-import-source-type").value,
                    ai = e(".source-area");
                $source = e("#dropdown-import-source");
                $source.find("option").not('[data-type="notselect"]').remove();
                if (aj === "trial" || aj === "icsr") {
                    ai.show();
                    if (ak && aj) {
                        e.ajax({
                            type: "POST",
                            url: "/import/load-sources.json",
                            data: {
                                product: ak,
                                sourceType: aj
                            },
                            success: function(ap) {
                                if (ap.options) {
                                    var am = [];
                                    for (var ao = 0, an = ap.options.length; ao < an; ao++) {
                                        var al = ap.options[ao];
                                        am.push(z.replace(z.html.defaultOption, {
                                            VALUE: al.value,
                                            LABEL: al.label
                                        }))
                                    }
                                    $source.append(am.join(""))
                                }
                            },
                            dataType: "json"
                        })
                    }
                } else {
                    ai.hide()
                }
            }

            function af(aj) {
                var ak = aj.prop("id").replace(/-file$/i, ""),
                    ai = aj.closest(".search-wrap");
                aj.fileupload({
                    url: "/file/import",
                    dataType: "json",
                    add: function(an, al) {
                        var am = {
                            product: undefined,
                            sourceType: undefined,
                            sourceKey: undefined
                        };
                        al.formData = am;
                        al.formData.product = document.getElementById("dropdown-import-product").value;
                        al.formData.sourceType = document.getElementById("dropdown-import-source-type").value;
                        al.formData.sourceKey = document.getElementById("dropdown-import-source").value;
                        al.context = ai.on("click", "#btn-import-file", function() {
                            al.formData.product = document.getElementById("dropdown-import-product").value;
                            al.formData.sourceType = document.getElementById("dropdown-import-source-type").value;
                            al.formData.sourceKey = document.getElementById("dropdown-import-source").value;
                            if (al.formData.product == undefined || e.trim(al.formData.product) == "" || al.formData.sourceType == undefined || e.trim(al.formData.sourceType) == "" || (al.formData.sourceType == "trial" && (al.formData.sourceKey == undefined || e.trim(al.formData.sourceKey) == "")) || (al.formData.sourceType == "icsr" && (al.formData.sourceKey == undefined || e.trim(al.formData.sourceKey) == ""))) {
                                alert(q["import"]["error.notSelectSource"])
                            } else {
                                if (al.formData.sourceType === "icsr") {
                                    if (/xml/i.test(document.getElementById(ak).value)) {
                                        al.submit().done(function(ap, ao) {
                                            if (ap.result == true) {
                                                setTimeout(function() {
                                                    location.href = "/import/" + ap.dataKey
                                                }, 1000)
                                            } else {
                                                alert(q["import"]["error.common"])
                                            }
                                        })
                                    } else {
                                        alert(q["import"]["error.fileTypeNotMatchXml"])
                                    }
                                } else {
                                    if (al.formData.sourceType === "trial") {
                                        if (/xlsx|xml/i.test(document.getElementById(ak).value)) {
                                            al.submit().done(function(ap, ao) {
                                                if (ap.result == true) {
                                                    setTimeout(function() {
                                                        location.href = "/import/" + ap.dataKey
                                                    }, 1000)
                                                } else {
                                                    alert(q["import"]["error.common"])
                                                }
                                            })
                                        } else {
                                            alert(q["import"]["error.fileTypeNotMatchXlsxXml"])
                                        }
                                    } else {
                                        if (/xlsx/i.test(document.getElementById(ak).value)) {
                                            al.submit().done(function(ap, ao) {
                                                if (ap.result == true) {
                                                    setTimeout(function() {
                                                        location.href = "/import/" + ap.dataKey
                                                    }, 1000)
                                                } else {
                                                    alert(q["import"]["error.common"])
                                                }
                                            })
                                        } else {
                                            alert(q["import"]["error.fileTypeNotMatchXlsx"])
                                        }
                                    }
                                }
                            }
                        })
                    },
                    change: function(an, am) {
                        var ao = am.files[0]["name"],
                            al = document.getElementById("dropdown-import-source-type").value;
                        if (am && am.files && am.files.length > 0 && am.files[0]["name"]) {
                            if (al === undefined || al === "") {
                                alert(q["import"]["error.notSelectSourceType"])
                            } else {
                                if (al === "icsr") {
                                    if (/xml/i.test(ao.substring(ao.lastIndexOf(".") + 1, ao.length))) {
                                        document.getElementById(ak).value = am.files[0]["name"]
                                    } else {
                                        document.getElementById(ak).value = "";
                                        alert(q["import"]["error.fileTypeNotMatchXml"])
                                    }
                                } else {
                                    if (al === "trial") {
                                        if (/xlsx|xml/i.test(ao.substring(ao.lastIndexOf(".") + 1, ao.length))) {
                                            document.getElementById(ak).value = am.files[0]["name"]
                                        } else {
                                            document.getElementById(ak).value = "";
                                            alert(q["import"]["error.fileTypeNotMatchXlsxXml"])
                                        }
                                    } else {
                                        if (/xlsx/i.test(ao.substring(ao.lastIndexOf(".") + 1, ao.length))) {
                                            document.getElementById(ak).value = am.files[0]["name"]
                                        } else {
                                            document.getElementById(ak).value = "";
                                            alert(q["import"]["error.fileTypeNotMatchXlsx"])
                                        }
                                    }
                                }
                            }
                        }
                    }
                })
            }

            function ae(am) {
                var al = e("#info-result"),
                    ak = undefined,
                    aj = undefined,
                    an = undefined;
                e.ajax({
                    type: "POST",
                    url: "/import/" + am + "/error-info",
                    async: false,
                    success: function(ap) {
                        var ao = ap.result;
                        if (ap.result != undefined) {
                            al.find("#info-result-userId .filter-text2").text(ao.userId);
                            al.find("#info-result-inputTime .filter-text2").text(ao.inputTime.substring(0, 16));
                            al.find("#info-result-status .filter-text2").text(ao.status);
                            if (ao.message != undefined && ao.message != "") {
                                al.find("#info-result-message .filter-text2").text(ao.message)
                            } else {
                                al.find("#info-result-message").hide()
                            }
                            al.show();
                            ak = ao.status;
                            aj = ap.firstContent;
                            an = ap
                        }
                    },
                    dataType: "json"
                });
                if (ak === "ERROR") {
                    if (aj != undefined) {
                        var ai = e("#list-error-wrap").empty();
                        ai.paginatedList({
                            tableWrapClassName: "contents-detail",
                            tableClassName: "test-table",
                            countable: true,
                            editable: false,
                            countCellWidthRate: "4%",
                            columns: an.paginatedColumns,
                            initContent: an.firstContent,
                            initPageIndex: an.initPageIndex,
                            rowNum: an.initRowCount,
                            loaderURL: "/import/" + am + "/error-list"
                        })
                    }
                }
                return ak
            }
        }
        if (document.getElementById("dataset-export")) {
            e(document.body).on("change", "#dropdown-dataset-product", function(ak) {
                var aj = ak.target.value,
                    ai = e(".sourcetype-area");
                if (aj == "") {
                    ai.hide();
                    e("#dropdown-dataset-source-type").find('option[data-type="notselect"]:eq(0)').prop("selected", true)
                } else {
                    ai.show()
                }
                Y()
            });
            e(document.body).on("change", "#dropdown-dataset-source-type", function() {
                Y()
            });
            e(document.body).on("click", "#btn-dataset-export", function() {
                var ai = ['<input type="hidden" name="product" value="' + document.getElementById("dropdown-dataset-product").value + '"/>', '<input type="hidden" name="sourceType" value="' + document.getElementById("dropdown-dataset-source-type").value + '"/>', '<input type="hidden" name="sourceKey" value="' + document.getElementById("dropdown-dataset-source").value + '"/>'];
                m("/dataset/export", ai)
            });

            function Y() {
                var ak = document.getElementById("dropdown-dataset-product").value,
                    aj = document.getElementById("dropdown-dataset-source-type").value,
                    ai = e(".source-area");
                $source = e("#dropdown-dataset-source");
                $source.find("option").not('[data-type="notselect"]').remove();
                if (aj === "trial" || aj === "icsr") {
                    ai.show();
                    if (ak && aj) {
                        e.ajax({
                            type: "POST",
                            url: "/import/load-sources.json",
                            data: {
                                product: ak,
                                sourceType: aj
                            },
                            success: function(ap) {
                                if (ap.options) {
                                    var am = [];
                                    for (var ao = 0, an = ap.options.length; ao < an; ao++) {
                                        var al = ap.options[ao];
                                        am.push(z.replace(z.html.defaultOption, {
                                            VALUE: al.value,
                                            LABEL: al.label
                                        }))
                                    }
                                    $source.append(am.join(""))
                                }
                            },
                            dataType: "json"
                        })
                    }
                } else {
                    ai.hide()
                }
            }
        }
    });
    e(window).load(function() {
        var U = document.getElementById("login-error-cube");
        if (U) {
            var W = e(U);
            if (W.is(":visible")) {
                W.css("top", "0")
            } else {
                W.css({
                    display: "",
                    top: "300px"
                })
            }
        }
        var af = e("input"),
            V = [],
            ae = [],
            G = [],
            az = [],
            ad = [];
        for (var ax = 0, O = af.length; ax < O; ax++) {
            var aq = af.eq(ax),
                L = aq.attr("data-datatype");
            if (L == "DATE") {
                V.push(aq[0])
            } else {
                if (L == "TIME") {
                    ae.push(aq[0])
                } else {
                    if (aq.attr("data-code")) {
                        G.push(aq)
                    } else {
                        if (aq.attr("data-source")) {
                            az.push(aq)
                        } else {
                            if (/file/i.test(aq.prop("type")) && !/fileImport/i.test(aq.attr("name")) && !aq.is("._not-entry")) {
                                ad.push(aq)
                            }
                        }
                    }
                }
            }
        }
        var E = e(V);
        E.cubedatepicker({
            isBeginElementId: function(aF) {
                return /_BEGIN_DATE$/i.test(aF)
            },
            isEndElementId: function(aF) {
                return /_END_DATE$/i.test(aF)
            },
            oppositeElement: function() {
                var aG = this.id,
                    aF;
                if (/_BEGIN_DATE$/i.test(aG)) {
                    aF = aG.replace(/_BEGIN_DATE$/i, "_END_DATE")
                } else {
                    if (/_END_DATE$/i.test(aG)) {
                        aF = aG.replace(/_END_DATE$/i, "_BEGIN_DATE")
                    }
                }
                if (!aF) {
                    return []
                }
                return E.filter(function() {
                    return this.id == aF
                })
            }
        });
        e(ae).timepicker();
        for (var aE = 0, aa = G.length; aE < aa; aE++) {
            var aB = G[aE],
                T = document.getElementById(aB.prop("id") + "-options").getElementsByTagName("li"),
                Z = [];
            for (var av = 0, am = T.length; av < am; av++) {
                Z.push(T[av].innerHTML)
            }
            aB.autocomplete({
                source: Z,
                minLength: 0
            }).data("ui-autocomplete")._renderItem = function(aF, aG) {
                return e("<li><a>" + aG.label.replace(new RegExp(this.term, "gi"), function() {
                    return ['<span style="color:#ff5757">', arguments[0], "</span>"].join("")
                }) + "</a></li>").appendTo(aF)
            }
        }
        var ap = {};
        for (var at = 0, S = az.length; at < S; at++) {
            var N = az[at];
            N.on("change", function(aF) {
                var aG = e(aF.currentTarget).attr("data-source");
                if (/KIMS/i.test(aG)) {
                    e("#DH_GENERIC_INFO,#CM_GENERIC_NAME").val("");
                    e("#DH_ATC_VER,#CM_ATC_VER").val("").trigger("change");
                    e("#DH_ATC_TERM,#CM_ATC_TERM").val("");
                    e("#DH_ATC_CODE_5,#CM_ATC_CODE_5").val("");
                    e("#DH_MFDS_DM_TERM,#CM_MFDS_DM_TERM").val("");
                    e("#DH_MFDS_DM_CODE,#CM_MFDS_DM_CODE").val("");
                    e("#DH_MFDS_DM_TERM_EN,#CM_MFDS_DM_TERM_EN").val("")
                } else {
                    if (/SITE/i.test(aG)) {
                        e("#SITE_ADDRESS").val("")
                    }
                }
            });
            N.autocomplete({
                minLength: 1,
                source: function(aH, aF) {
                    var aG = aH.term,
                        aI = e(this.element).attr("data-source");
                    if (ap[aI] && ap[aI][aG]) {
                        aF(ap[aI][aG]);
                        return
                    }
                    e.ajax({
                        url: "/entry/auto-complete",
                        method: "POST",
                        dataType: "json",
                        data: {
                            source: aI,
                            term: aG
                        },
                        hideLoading: true,
                        success: function(aJ) {
                            if (aJ.source) {
                                if (ap[aI] === undefined) {
                                    ap[aI] = {}
                                }
                                ap[aI][aG] = aJ.source;
                                aF(aJ.source)
                            }
                        }
                    })
                },
                select: function(aH, aM) {
                    var aF = e(this).attr("data-source");
                    if (/KIMS/i.test(aF)) {
                        var aP = "",
                            aK = "",
                            aI = "",
                            aL = "",
                            aJ = "",
                            aG = "",
                            aO = "";
                        if (aM.item) {
                            if (aM.item["info_english"] != undefined) {
                                aP = aM.item["info_english"]
                            }
                            if (aM.item["atc_version"] != undefined) {
                                aK = aM.item["atc_version"]
                            }
                            if (aM.item["atc_term"] != undefined) {
                                aI = aM.item["atc_term"]
                            }
                            if (aM.item["atc_code"] != undefined) {
                                aL = aM.item["atc_code"]
                            }
                            if (aM.item["ib"]) {
                                e.ajax({
                                    url: "/entry/auto-complete",
                                    method: "POST",
                                    dataType: "json",
                                    data: {
                                        source: "KIMS_MFDS",
                                        term: aM.item["ib"]
                                    },
                                    hideLoading: true,
                                    async: false,
                                    success: function(aQ) {
                                        if (aQ.source && aQ.source) {
                                            aJ = aQ.source["term"], aG = aQ.source["code"], aO = aQ.source["english"]
                                        }
                                    }
                                })
                            }
                        }
                        e("#DH_GENERIC_INFO,#CM_GENERIC_NAME").val(aP);
                        e("#DH_ATC_VER,#CM_ATC_VER").val(aK).trigger("change");
                        e("#DH_ATC_TERM,#CM_ATC_TERM").val(aI);
                        e("#DH_ATC_CODE_5,#CM_ATC_CODE_5").val(aL);
                        e("#DH_MFDS_DM_TERM,#CM_MFDS_DM_TERM").val(aJ);
                        e("#DH_MFDS_DM_CODE,#CM_MFDS_DM_CODE").val(aG);
                        e("#DH_MFDS_DM_TERM_EN,#CM_MFDS_DM_TERM_EN").val(aO)
                    } else {
                        if (/SITE/i.test(aF)) {
                            var aN = "";
                            if (aM.item && aM.item["address"]) {
                                aN = aM.item["address"]
                            }
                            e("#SITE_ADDRESS").val(aN)
                        }
                    }
                }
            }).data("ui-autocomplete")._renderItem = function(aF, aG) {
                return e("<li><a>" + aG.label.replace(new RegExp(this.term, "gi"), function() {
                    return ['<span style="color:#ff5757">', arguments[0], "</span>"].join("")
                }) + "</a></li>").appendTo(aF)
            }
        }
//        for (var aA = 0, I = ad.length; aA < I; aA++) {
//            y(ad[aA])
//        }
        var P = function(aF, aL) {
            var aH = new RegExp("^" + aL + "_([a-zA-Z0-9_]+)$"),
                aK = aF.find("input,textarea");
            for (var aJ = 0, aI = aK.length; aJ < aI; aJ++) {
                var aM = aK.eq(aJ),
                    aG = aM.prop("name");
                if (aH.test(aG)) {
                    aM.val("")
                }
            }
        };
        var ao = e("textarea").filter('[data-datatype="MEDCOD"]'),
            F = [];
        for (var au = 0, Q = ao.length; au < Q; au++) {
            var aj = ao.eq(au);
            aj.medicalcoding({
                baseUrl: "/entry/medical-code",
                codeType: function(aF) {
                    return aF.prop("name").replace(/^.+_(MFDS_INGR|MFDS_DM|KCD|MEDDRA|WHOART|ATC)_.+$/i, "$1")
                },
                codeVersion: function(aG) {
                    if (/MFDS_INGR|MFDS_DM/.test(aG.prop("name"))) {
                        return undefined
                    }
                    var aI = aG.prop("name").replace(/^(.+_(KCD|MEDDRA|WHOART|ATC))_.+$/i, "$1_VER"),
                        aH = aG.closest(".item-row-wrap").find("#" + aI),
                        aF = undefined;
                    if (aH.length > 0) {
                        aF = aH.prop("value")
                    }
                    if (aF === undefined || aF.length == 0) {
                        alert(q.MEDCOD_VERSION_EMPTY || "Please select medical Code Version.");
                        return undefined
                    }
                    return aF
                }
            });
            var J = aj.prop("name").replace(/^(.+_(MFDS_INGR|MFDS_DM|KCD|MEDDRA|WHOART|ATC))_.+$/i, "$1"),
                X = document.getElementById(J + "_VER");
            if (X) {
                F.push(X)
            }
        }
        ao.on("change.medicalcoding", function(aF, aI) {
            var aN = e(aF.currentTarget),
                aL = aN.closest(".item-row-wrap"),
                aH = new RegExp("^" + aN.prop("name").replace(/^(.+_(MFDS_INGR|MFDS_DM|KCD|MEDDRA|WHOART|ATC))_.+$/i, "$1") + "_([a-zA-Z0-9_]+)$"),
                aG = aL.find("input,textarea");
            for (var aJ = 0, aP = aG.length; aJ < aP; aJ++) {
                var aM = aG.eq(aJ),
                    aK = aM.prop("name");
                if (aH.test(aK)) {
                    var aO = aK.replace(aH, "$1");
                    if (aI[aO]) {
                        aM.val(aI[aO])
                    } else {
                        if (aI[aO + "_CODE"]) {
                            aM.val(aI[aO + "_CODE"])
                        } else {
                            if (!aM.is(aN)) {
                                aM.val("")
                            }
                        }
                    }
                }
            }
        });
        if (F.length > 0) {
            e(F).on("change", function(aG) {
                var aF = e(aG.target).closest(".item-row-wrap"),
                    aH = aG.target.id.replace(/_VER$/i, "");
                P(aF, aH)
            })
        }
        ao.on("clear.medicalcoding", function(aG) {
            var aF = e(aG.target).closest(".item-row-wrap"),
                aH = aG.target.name.replace(/^(.+_(MFDS_INGR|MFDS_DM|KCD|MEDDRA|WHOART|ATC))_.+$/i, "$1");
            P(aF, aH)
        });

        function K(aK, aL) {
            var aG = /^([0-9]{4})-([0-9]{2})-([0-9]{2})$/;
            if (aG.test(aK) && aG.test(aL)) {
                var aJ = aG.exec(aK),
                    aI = aG.exec(aL),
                    aF = new Date(parseInt(aJ[1], 10), parseInt(aJ[2], 10) - 1, parseInt(aJ[3], 10), 0, 0, 0),
                    aH = new Date(parseInt(aI[1], 10), parseInt(aI[2], 10) - 1, parseInt(aI[3], 10), 0, 0, 0);
                return (aH.getTime() - aF.getTime()) / (24 * 60 * 60 * 1000)
            }
            return null
        }
        var ai = document.getElementById("AE_BEGIN_DATE"),
            ay = document.getElementById("AE_END_DATE"),
            M = document.getElementById("AE_DURATION");
        if (ai && ay && M) {
            e([ai, ay]).on("change.datepicker", function() {
                var aF = K(ai.value, ay.value);
                if (aF === null) {
                    M.value = ""
                } else {
                    M.value = aF
                }
            })
        }
        var R = document.getElementById("CM_BEGIN_DATE"),
            ar = document.getElementById("CM_END_DATE"),
            ac = document.getElementById("CM_DAYS");
        if (R && ar && ac) {
            e([R, ar]).on("change.datepicker", function() {
                var aF = K(R.value, ar.value);
                if (aF === null) {
                    ac.value = ""
                } else {
                    ac.value = aF + 1
                }
            })
        }
        var ab = /^\/case\/([0-9]*)\/(icsr)\/([0-9]*)\/([0-9]*)(-ae{1})/,
            aD = ab.test(window.location.pathname);
        var al = document.getElementById("AE_IS_MAIN"),
            ag = document.getElementById("AE_SERIOUS"),
            ak = document.getElementById("IS_MNFT_REPORT"),
            aC = document.getElementById("IS_MNFT_DUE"),
            H = document.getElementById("exists-mnft-report-due"),
            ah = document.getElementById("mnft-event-due"),
            an = document.getElementById("mnft-serious-due"),
            aw = document.getElementById("mnft-is-report"),
            D = document.getElementById("mnft-due-date");
        if (H && aD === false) {
            var Y = e([al, ag]);
            aw.value = ak.value;
            D.value = aC.value;
            Y.on("change.radiotoggle", function() {
                if (al.value == "M" && /(1|2)/.test(ag.value)) {
                    if (ag.value == "1") {
                        aC.value = an.value
                    } else {
                        if (ag.value == "2") {
                            aC.value = ah.value
                        }
                    }
                    if (typeof aC.value === "string" && aC.value.length > 0) {
                        ak.value = "1";
                        ak.className = d;
                        document.getElementById("IS_MNFT_REPORT-1").checked = true;
                        e(ak).trigger("change.radiotoggle")
                    } else {
                        ak.value = "";
                        aC.value = "";
                        document.getElementById("IS_MNFT_REPORT-1").checked = false;
                        document.getElementById("IS_MNFT_REPORT-2").checked = false;
                        e(ak).trigger("change.radiotoggle")
                    }
                } else {
                    if (al.value != "M") {
                        ak.value = aw.value;
                        aC.value = D.value;
                        document.getElementById("IS_MNFT_REPORT-1").checked = (ak.value == "1") ? true : false;
                        document.getElementById("IS_MNFT_REPORT-2").checked = (ak.value == "2") ? true : false;
                        e(ak).trigger("change.radiotoggle")
                    }
                }
            })
        }
        if (ak && ak.value) {
            ak.className = d
        }
    })
})(jQuery);
(function(d) {
    var e = document.initializerModel || {};
    var a = undefined,
        c = undefined,
        b = undefined;
    d.entryChecker = function() {
        a = undefined;
        c = undefined;
        b = undefined;
        var g = window.location.pathname,
            f = /^\/case\/([0-9]*)\/(trial|spontaneous|literature|other|icsr)\/([0-9]*)\/([0-9]*)(-{1})?([a-z]*)?/;
        if (f.test(g)) {
            var h = f.exec(g)[6];
            switch (h) {
                case undefined:
                    a = d("#case-BASE_INFO");
                    c = a.children(".item-row-wrap");
                    break;
                case "mh":
                    a = d("#case-MH");
                    c = a.children(".item-row-wrap");
                    break;
                case "dh":
                    a = d("#case-DH");
                    c = a.children(".item-row-wrap");
                    break;
                case "ae":
                    a = d("#case-AE");
                    c = a.children(".item-row-wrap");
                    break;
                case "lab":
                    a = d("#case-LAB");
                    c = a.children(".item-row-wrap");
                    break;
                case "cm":
                    a = d("#case-CM");
                    c = a.children(".item-row-wrap");
                    break;
                case "relation":
                    a = d("#case-RELATION");
                    c = a.children("table");
                    c.find('tr[data-role="Suspect"] input').on("change", function(i) {
                        d("#relation_suspect_change").val("true")
                    });
                    break;
                case "final":
                    a = d("#case-FINAL");
                    c = a.children(".item-row-wrap");
                    break;
                default:
                    break
            }
        } else {
            if (/^\/(product|case|misc).*/.test(g)) {
                a = d(".contents-detail");
                c = a.find(".item-row-wrap")
            }
        }
        if (a !== undefined && c !== undefined) {
            c.detectchanged("init")
        }
        d(window).bind("beforeunload", function() {
            if ((c !== undefined && c.detectchanged()) || (b !== undefined && b.detectchanged())) {
                return e.confirmWithoutSave || "Move to another page without saving?"
            }
        })
    };
    d.pagingFormChecker = function() {
        if (a !== undefined) {
            b = a.children("._paging-form-wrap");
            if (b.length > 0 && b.is(":visible")) {
                b.detectchanged("init")
            }
        }
    };
    d(window).load(function() {
        d.entryChecker();
        d.pagingFormChecker()
    })
})(jQuery);
(function(d, a) {
    var c = "".concat('<div class="layer-wrap" style="width:650px;">', '<div class="layer-pd">', '<div class="notice-content-wrap">', '<table cellpadding="0" cellspacing="0" border="0" width="100%" class="notice-table">', '<colgroup><col style="width:45%;" /><col style="width:10%;" /><col style="width:20%;" /><col style="width:25%;" /></colgroup>', '<tr class="tr-selected nohover">', "<td><div>{{TITLE}}</div></td>", '<td><div class="tCenter">{{FILE_ICON}}</div></td>', '<td><div class="tCenter">{{EFFECTIVE}}</div></td>', '<td><div class="tCenter">{{WRITER}}</div></td>', "</tr>", '<tr class="nohover"><td colspan="4"><div>{{CONTENT_HTML}}</div>{{ATTACH_HTML}}</td></tr>', "</table>", "</div>", '<div class="layer-btn">', '<input type="button" value="Confirm" class="ui-button ui-widget ui-state-default ui-corner-all notice" role="button" aria-disabled="false">', "</div>", "</div>", "</div>");
    d(a).on("ready", function() {
        var f = d(".notice-table-wrap");
        if (f.length > 0) {
            f.on("click", "tr[data-key]", function(i) {
                var g = d(i.currentTarget),
                    h = g.data("key");
                d.ajax("/admin/notice/view", {
                    data: {
                        key: h
                    },
                    dataType: "json",
                    success: function(o) {
                        if (o.notice) {
                            var j = o.notice;
                            var l = c.replace(/\{\{(.+?)\}\}/g, function() {
                                var p = arguments[1];
                                if (p == "TITLE") {
                                    return j.title
                                }
                                if (p == "FILE_ICON") {
                                    return j.attachment ? '<img src="/resources/image/attach.png" alt="" />' : "&nbsp;"
                                }
                                if (p == "EFFECTIVE") {
                                    return j.effective
                                }
                                if (p == "WRITER") {
                                    return j.writer
                                }
                                if (p == "CONTENT_HTML") {
                                    return j.content
                                }
                                if (p == "ATTACH_HTML" && j.attachment) {
                                    return '<div class="notice-attach"><span data-key="' + j.key + '"><img src="/resources/image/attach.png" alt="" /> ' + j.attachment + "</span></div>"
                                }
                                return ""
                            })
                        }
                        var n = d(l),
                            m = d(a.body);
                        m.append(n);
                        n.position({
                            at: "center center",
                            my: "center center",
                            of: m
                        });
                        n.on("click", 'input[type="button"].ui-button', function() {
                            n.remove();
                            m.off("click", k)
                        });
                        m.on("click", k);
                        n.on("click", ".notice-attach span", function(r) {
                            r.stopPropagation();
                            var p = d(r.currentTarget),
                                q = p.data("key");
                            b("/admin/notice/attachment", ['<input type="hidden" name="key" value="' + q + '"/>'])
                        });

                        function k(q) {
                            var p = d(q.target);
                            if (p.is(n) || p.parents().filter(n).length > 0) {
                                q.stopPropagation();
                                return
                            }
                            n.remove();
                            m.off("click", k)
                        }
                    },
                    type: "POST",
                    hideLoading: true
                })
            })
        }
    });
    var e = 0;

    function b(j, h) {
        e += 1;
        var f = window,
            i = d('<form style="display:none;"></form>'),
            g = d('<iframe src="javascript:false;" name="iframe-download-' + e + '"></iframe>').bind("load", function() {
                g.unbind("load").bind("load", function() {
                    if (g.contents().find("#form-login").length > 0) {
                        f.location.href = f.location.pathname
                    } else {
                        d('<iframe src="javascript:false;"></iframe>').appendTo(i);

                        window.setTimeout(function() {
                            i.remove()
                        }, 0)
                    }
                })
            });
        i.prop("target", g.prop("name")).prop("action", j).prop("method", "POST");
        if (h) {
            i.html(h.join(""))
        }
        i.append(g).appendTo(a.body);
        i.submit()
    }
})(jQuery, document);
(function(g) {
    var m = {
        conditionItemWrap: '<div class="word-selected-wrap"><div class="word-selected">#{CONDITION_LABEL}</div><div class="word-del">x</div>#{HIDDEN_HTML}</div>',
        conditionData: '<input type="hidden" name="itemId" value="#{ITEM_ID}"/><input type="hidden" name="valueFirst" value="#{VALUE_FIRST}"/><input type="hidden" name="valueSecond" value="#{VALUE_SECOND}"/><input type="hidden" name="mode" value="#{MODE}"/><input type="hidden" name="label" value="#{LABEL}"/>',
        notRangeCondition: '#{ITEM_LABEL} <span>#{CONDITION_SYMBOL}</span> #{CONDITION_VALUE}<input type="hidden" name="condition-value" value="#{CONDITION_VALUE}"/>',
        rangeCondition: "#{LOW_VALUE} <span>&lt;=</span> #{ITEM_LABEL} <span>&lt;=</span> #{HIGH_VALUE}",
        emptyCondition: "#{ITEM_LABEL} is empty",
        notEmptyCondition: "#{ITEM_LABEL} is not empty",
        codeOption: '<option value="#{VALUE}">#{LABEL}</option>',
        addLibrary: "".concat('<div><div class="add_library_top">The number of available storage library has exceeded.<br/>Remove the library that is stored first, do you store?</div>', '<table cellpadding="0" cellspacing="0" border="0" width="100%" class="layer-table1">', '<colgroup><col width="35%"><col width="65%"></colgroup>', "<tbody>", '<tr><th>#{SELECT_LABEL}</th><td><select id="library-item">#{OPTIONS}</select></td></tr>', '<tr><th>#{NAME_LABEL}</th><td><input type="TEXT_INPUT" id="name"/></td></tr>', "</tbody>", "</table></div>"),
        addLibraryItemWrap: '<li><div id="button-addLibrary-condition">#{LIB_NAME} #{HIDDEN_HTML}</div></li>',
        addLibraryItem: "#{INPUT_VALUE}",
        addLibraryItemKey: '<input type="hidden" name="libKey" value="#{LIB_KEY}"/><input type="hidden" name="libName" value="#{LIB_NAME}">'
    };
    var c;

    function n(s, r) {
        return s.replace(/#{([A-Z_]+)}/g, function() {
            var t = arguments[1];
            if (r[t]) {
                return r[t]
            }
            return ""
        })
    }

    function a(r) {
        var v = r.currentTarget,
            x = document.getElementById("search-condition").options,
            w = v.value,
            t = (c && c[w]),
            z = false,
            u;
        for (var s = 0, y = x.length; s < y; s++) {
            if (/(range|like)/.test(x[s].value)) {
                z = z || x[s].selected;
                x[s].disabled = t
            } else {
                if (!u) {
                    u = x[s]
                }
            }
        }
        if (z) {
            if (u) {
                u.selected = true
            } else {
                x[0].selected = true
            }
        }
    }

    function b(t) {
        var x = t.currentTarget,
            A = null;
        if (x.id != "search-condition") {
            A = document.getElementById("search-condition").value
        } else {
            A = t.currentTarget.value
        }
        var r = g("#search-value-wrap"),
            s = document.getElementById("search-item"),
            v = (s.value && c && c[s.value]);
        if (/empty/i.test(A)) {
            r.html("")
        } else {
            if (A == "range") {
                r.html('<input type="text" id="search-value-before" /> ~ <input type="text" id="search-value-after" />')
            } else {
                if (v) {
                    var u = [],
                        w = c[s.value];
                    for (var y = 0, z = w.length; y < z; y++) {
                        var B = w[y];
                        u.push(n(m.codeOption, {
                            VALUE: B.DB_VALUE,
                            LABEL: B.UI_VALUE
                        }))
                    }
                    r.html('<select id="search-value">' + u.join("") + "</select>")
                } else {
                    r.html('<input type="text" id="search-value" />')
                }
            }
        }
    }

    function l() {
        var C = document.getElementById("search-item"),
            I = document.getElementById("search-condition");
        if (C.value == "") {
            alert("Please select item");
            return false
        }
        var G = I.value,
            J = {
                ITEM_ID: "",
                VALUE_FIRST: "",
                VALUE_SECOND: "",
                MODE: ""
            },
            H = {
                ITEM_LABEL: ""
            },
            F = C.options,
            v;
        for (var B = 0, y = F.length; B < y; B++) {
            if (F[B].selected) {
                v = F[B]
            }
            if (v) {
                break
            }
        }
        if (!v) {
            return false
        }
        var s;
        if (/empty$/i.test(G)) {
            var A = G == "empty";
            J.ITEM_ID = v.value;
            J.VALUE_FIRST = null;
            J.VALUE_SECOND = null;
            J.MODE = A ? "EQ" : "NOT";
            J.LABEL = v.innerHTML;
            H.ITEM_LABEL = v.innerHTML;
            var x = A ? m.emptyCondition : m.notEmptyCondition;
            s = n(m.conditionItemWrap, {
                CONDITION_LABEL: n(x, H),
                HIDDEN_HTML: n(m.conditionData, J)
            })
        } else {
            if (G == "range") {
                var E = document.getElementById("search-value-before"),
                    w = document.getElementById("search-value-after"),
                    t = E ? E.value : "",
                    z = w ? w.value : "";
                if (!t || !z) {
                    alert("Please Input Range Condition Value");
                    return false
                }
                J.ITEM_ID = v.value;
                J.VALUE_FIRST = t;
                J.VALUE_SECOND = z;
                J.MODE = "RANGE";
                J.LABEL = v.innerHTML;
                H.ITEM_LABEL = v.innerHTML;
                H.LOW_VALUE = t;
                H.HIGH_VALUE = z;
                s = n(m.conditionItemWrap, {
                    CONDITION_LABEL: n(m.rangeCondition, H),
                    HIDDEN_HTML: n(m.conditionData, J)
                })
            } else {
                var D = document.getElementById("search-value"),
                    u = D ? D.value : "";
                if (!u) {
                    alert("Please Input Condition Value");
                    return false
                }
                J.ITEM_ID = v.value;
                J.VALUE_FIRST = u;
                J.LABEL = v.innerHTML;
                H.ITEM_LABEL = v.innerHTML;
                if (/select/i.test(D.type)) {
                    H.CONDITION_VALUE = D.options[D.selectedIndex].innerHTML
                } else {
                    H.CONDITION_VALUE = u
                }
                if (G == "equal") {
                    J.MODE = "EQ";
                    H.CONDITION_SYMBOL = "="
                } else {
                    if (G == "like") {
                        J.MODE = "LIKE";
                        H.CONDITION_SYMBOL = "like"
                    } else {
                        if (G == "not-like") {
                            J.MODE = "NOTLIKE";
                            H.CONDITION_SYMBOL = "not like"
                        } else {
                            if (G == "not-equal") {
                                J.MODE = "NOT";
                                H.CONDITION_SYMBOL = "!="
                            } else {
                                alert("Not supported condition");
                                return false
                            }
                        }
                    }
                }
                s = n(m.conditionItemWrap, {
                    CONDITION_LABEL: n(m.notRangeCondition, H),
                    HIDDEN_HTML: n(m.conditionData, J)
                })
            }
        }
        var r = g("#conditions-wrap");
        r.append(s);
        document.getElementById("button-search-wrap").style.display = "";
        document.getElementById("button-addLibrary-wrap").style.display = "";
        return false
    }

    function d(r) {
        g(r.currentTarget).closest(".word-selected-wrap").remove();
        if (g("#conditions-wrap").find(".word-selected-wrap").length == 0) {
            document.getElementById("button-search-wrap").style.display = "none";
            document.getElementById("button-addLibrary-wrap").style.display = "none"
        } else {
            document.getElementById("button-search-wrap").style.display = "";
            document.getElementById("button-addLibrary-wrap").style.display = ""
        }
        return false
    }

    function e() {
        var r = g("#conditions-wrap").find("input").serializeArray();
        g.ajax({
            type: "POST",
            url: "/search-do.json",
            data: r,
            success: function(w) {
                var t = g("#list-search-result-wrap").empty();
                t.paginatedList({
                    tableWrapClassName: "contents-detail",
                    tableClassName: "test-table",
                    countable: true,
                    editable: false,
                    countCellWidthRate: "4%",
                    columns: w.headers,
                    initContent: w.resultData,
                    initPageIndex: 1,
                    loaderURL: "/search-do.json",
                    exportURL: "/search-export",
                    rowNum: 10,
                    extraParam: r
                });
                var s = g("#button-excel-download");
                s.off("click");
                if (w.resultData["totalCount"] == 0) {
                    g("#bottom-wrap").css("display", "none")
                } else {
                    g("#bottom-wrap").css("display", "");
                    var u = [];
                    for (var v = 0, x = r.length; v < x; v++) {
                        var y = r[v];
                        u.push('<input type="hidden" name="' + y.name + '" value="' + y.value + '"/>')
                    }
                    s.on("click", function() {
                        i("/search-export", u)
                    });
                    document.getElementById("button-search-wrap").style.display = "none"
                }
            },
            dataType: "json"
        })
    }
    var k = 0;

    function i(v, t) {
        k += 1;
        var r = window,
            u = g('<form style="display:none;"></form>'),
            s = g('<iframe src="javascript:false;" name="iframe-download-' + k + '"></iframe>').bind("load", function() {
                s.unbind("load").bind("load", function() {
                    if (s.contents().find("#form-login").length > 0) {
                        r.location.href = r.location.pathname
                    } else {
                        g('<iframe src="javascript:false;"></iframe>').appendTo(u);
                        window.setTimeout(function() {
                            u.remove()
                        }, 0)
                    }
                })
            });
        u.prop("target", s.prop("name")).prop("action", v).prop("method", "POST");
        if (t) {
            u.html(t.join(""))
        }
        u.append(s).appendTo(document.body);
        u.submit()
    }

    function f() {
        var z = g("#conditions-wrap").find(".word-selected-wrap"),
            t = [];
        for (var x = 0, A = z.length; x < A; x++) {
            var r = z.eq(x).find("input"),
                s = {};
            for (var u = 0, v = r.length; u < v; u++) {
                var y = r[u];
                s[y.name] = y.value
            }
            t.push(s)
        }
        if (t.length > 0) {
            g.storagesavejson("safety-search", t)
        }
    }

    function h() {
        var y = g.storageloadjson("safety-search", true, []);
        if (y && y.length > 0) {
            var s = [];
            for (var x = 0, z = y.length; x < z; x++) {
                var t = y[x],
                    v = {
                        ITEM_LABEL: t.label
                    },
                    u = {
                        ITEM_ID: t.itemId,
                        MODE: t.mode,
                        VALUE_FIRST: t.valueFirst,
                        VALUE_SECOND: t.valueSecond,
                        LABEL: t.label
                    },
                    A = "";
                if (t.mode == "RANGE") {
                    v.LOW_VALUE = t.valueFirst;
                    v.HIGH_VALUE = t.valueSecond;
                    A = n(m.conditionItemWrap, {
                        CONDITION_LABEL: n(m.rangeCondition, v),
                        HIDDEN_HTML: n(m.conditionData, u)
                    })
                } else {
                    if (u.VALUE_FIRST === null) {
                        var r = t.mode == "EQ" ? m.emptyCondition : m.notEmptyCondition;
                        A = n(m.conditionItemWrap, {
                            CONDITION_LABEL: n(r, v),
                            HIDDEN_HTML: n(m.conditionData, u)
                        })
                    } else {
                        v.CONDITION_VALUE = t["condition-value"];
                        if (t.mode == "EQ") {
                            v.CONDITION_SYMBOL = "="
                        } else {
                            if (t.mode == "LIKE") {
                                v.CONDITION_SYMBOL = "like"
                            } else {
                                if (t.mode == "NOT") {
                                    v.CONDITION_SYMBOL = "!="
                                }
                            }
                        }
                        A = n(m.conditionItemWrap, {
                            CONDITION_LABEL: n(m.notRangeCondition, v),
                            HIDDEN_HTML: n(m.conditionData, u)
                        })
                    }
                }
                s.push(A)
            }
            var w = g("#conditions-wrap");
            w.append(s.join(""));
            document.getElementById("button-search-wrap").style.display = "";
            document.getElementById("button-addLibrary-wrap").style.display = "";
            e()
        }
    }

    function j() {
        var u = g("#library-conditions-wrap").find("li").length;
        var s = [n(m.codeOption, {
                VALUE: "",
                LABEL: "Add New library"
            })],
            v, t = {},
            r;
        g.ajax({
            type: "POST",
            url: "/library-do.json",
            data: {
                propId: "SET_CNT_LIBRARY"
            },
            async: false,
            success: function(w) {
                if (g.isArray(w.data)) {
                    g.each(w.data, function(x, y) {
                        s.push(n(m.codeOption, {
                            VALUE: y.libraryKey,
                            LABEL: y.libraryName
                        }))
                    })
                }
                v = w.libraryCnt;
                if (v === undefined || v === null) {
                    v = 0
                }
            }
        });
        r = g(n(m.addLibrary, {
            SELECT_LABEL: "Select Library",
            OPTIONS: s.join(""),
            NAME_LABEL: "Name"
        }));
        t[("Save")] = function(x) {
            var w = g("#conditions-wrap").find("input").serializeArray();
            var z, y;
            z = g("#popover").find('[id="library-item"]').val();
            y = g.trim(g("#popover").find('input[id="name"]').val());
            if (y == null || y == "") {
                alert("Please Input Name");
                return false
            }
            w.push({
                name: "libName",
                value: y
            }, {
                name: "libKey",
                value: z
            });
            g.ajax({
                type: "POST",
                url: "/library-submit",
                data: w,
                success: function(A) {
                    location.reload()
                },
                dataType: "json",
                hideLoading: true
            });
            g.popoverdialog("close")
        };
        g(this).popoverdialog({
            title: "Create",
            width: 400,
            content: r,
            buttons: t
        });
        if (g("#library-conditions-wrap").find("li").length < v) {
            g("#popover").find(".add_library_top").hide()
        } else {
            g("#popover").find(".add_library_top").show();
            g.each(g("#popover").find('select[id="library-item"]'), function(w, y) {
                g(y[0]).attr("disabled", "disabled");
                g(y[1]).attr("selected", "selected");
                var x = g(y[1]).text();
                g("#popover").find('input[type="TEXT_INPUT"]').val(x)
            })
        }
        g("#popover").on("change", 'select[id="library-item"]', function(x) {
            var w = x.target.options[x.target.selectedIndex].text;
            if (x.target[0].text != w) {
                g("#popover").find('input[type="TEXT_INPUT"]').val(w)
            } else {
                g("#popover").find('input[type="TEXT_INPUT"]').val("")
            }
        })
    }

    function p() {
        var r = document.getElementById("search-item"),
            t = document.getElementById("search-condition");
        var x = g(this).find('input[name="libKey"]').val(),
            w, s, u = {
                ITEM_ID: "",
                VALUE_FIRST: "",
                VALUE_SECOND: "",
                MODE: ""
            },
            v = {
                ITEM_LABEL: ""
            };
        g(".word-selected-wrap").remove();
        g.ajax({
            type: "POST",
            url: "/filter-do",
            data: {
                libKey: x
            },
            async: false,
            success: function(y) {
                g.each(y.data, function(C, D) {
                    w = D.filterType;
                    var B = [],
                        E;
                    g.ajax({
                        type: "POST",
                        url: "/selectItems-data",
                        data: {
                            propId: "SUMMARY_SEARCH_REPORT",
                            value: D.filterCode,
                            colName: D.columnName
                        },
                        async: false,
                        success: function(F) {
                            g.each(F.data, function(G, H) {
                                B.push(H.itemLabel);
                                E = H.codeListJson
                            })
                        }
                    });
                    if (/(NULL)/.test(D.filterCode)) {
                        y.ITEM_ID = D.columnName;
                        y.VALUE_FIRST = null;
                        y.VALUE_SECOND = null;
                        y.MODE = w;
                        y.LABEL = B;
                        v.ITEM_LABEL = B;
                        if (w == "EQ") {
                            var A = m.emptyCondition
                        } else {
                            if (w == "NOT") {
                                var A = m.notEmptyCondition
                            }
                        }
                        s = n(m.conditionItemWrap, {
                            CONDITION_LABEL: n(A, v),
                            HIDDEN_HTML: n(m.conditionData, y)
                        })
                    } else {
                        if (w == "RANGE") {
                            y.ITEM_ID = D.columnName;
                            y.VALUE_FIRST = D.filterCode;
                            y.VALUE_SECOND = D.filterAdd;
                            y.MODE = w;
                            y.LABEL = B;
                            v.ITEM_LABEL = B;
                            v.LOW_VALUE = D.filterCode;
                            v.HIGH_VALUE = D.filterAdd;
                            s = n(m.conditionItemWrap, {
                                CONDITION_LABEL: n(m.rangeCondition, v),
                                HIDDEN_HTML: n(m.conditionData, y)
                            })
                        } else {
                            if (E == null) {
                                E = D.filterCode
                            }
                            y.ITEM_ID = D.columnName;
                            y.VALUE_FIRST = D.filterCode;
                            y.VALUE_SECOND = null;
                            y.LABEL = B;
                            v.ITEM_LABEL = B;
                            v.CONDITION_VALUE = E;
                            if (w == "EQ") {
                                y.MODE = w;
                                v.CONDITION_SYMBOL = "="
                            } else {
                                if (w == "LIKE") {
                                    y.MODE = w;
                                    v.CONDITION_SYMBOL = "like"
                                } else {
                                    if (w == "NOTLIKE") {
                                        y.MODE = w;
                                        v.CONDITION_SYMBOL = "not like"
                                    } else {
                                        if (w == "NOT") {
                                            y.MODE = w;
                                            v.CONDITION_SYMBOL = "!="
                                        }
                                    }
                                }
                            }
                            s = n(m.conditionItemWrap, {
                                CONDITION_LABEL: n(m.notRangeCondition, v),
                                HIDDEN_HTML: n(m.conditionData, y)
                            })
                        }
                    }
                    var z = g("#conditions-wrap");
                    z.append(s)
                });
                document.getElementById("button-search-wrap").style.display = "";
                document.getElementById("button-addLibrary-wrap").style.display = "";
                return false
            }
        })
    }

    function o() {
        var r = g("#library-conditions-wrap"),
            t, u = {
                INPUT_VALUE: ""
            },
            s = {
                LIB_KEY: "",
                LIB_NAME: ""
            };
        g.ajax({
            type: "POST",
            url: "/library-do.json",
            data: {},
            success: function(v) {
                if (g.isArray(v.data)) {
                    g.each(v.data, function(w, x) {
                        u.INPUT_VALUE = x.libraryName;
                        s.LIB_KEY = x.libraryKey;
                        s.LIB_NAME = x.libraryName;
                        t = n(m.addLibraryItemWrap, {
                            LIB_NAME: n(m.addLibraryItem, u),
                            HIDDEN_HTML: n(m.addLibraryItemKey, s)
                        });
                        r.find("ul.column01").append(t)
                    })
                }
            }
        });
        r.find("ul.column01").on("click", "#button-addLibrary-condition", p)
    }

    function q(t) {
        var u = g(t.currentTarget.parentElement),
            x = document.getElementById("search-condition").options,
            z, y, B, w, A, s;
        z = u.find('input:hidden[name="itemId"]').val();
        y = u.find(':hidden[name="valueFirst"]').val();
        B = u.find(':hidden[name="valueSecond"]').val();
        w = u.find(':hidden[name="mode"]').val();
        A = u.find(':hidden[name="label"]').val();
        g('#search-item option[value="' + z + '"]').prop("selected", true);
        if (w == "EQ") {
            if (y == "") {
                s = "empty"
            } else {
                s = "equal"
            }
        } else {
            if (w == "LIKE") {
                s = "like"
            } else {
                if (w == "NOTLIKE") {
                    s = "not-like"
                } else {
                    if (w == "NOT") {
                        if (y == "") {
                            s = "not-empty"
                        } else {
                            s = "not-equal"
                        }
                    } else {
                        if (w == "RANGE") {
                            s = "range"
                        }
                    }
                }
            }
        }
        g('#search-condition option[value="' + s + '"]').prop("selected", true);
        b(t);
        var r = document.getElementById("search-item"),
            v = c[r.value];
        if (v) {
            g('#search-value option[value="' + y + '"]').prop("selected", true)
        } else {
            if (s == "range") {
                g("#search-value-before").val(y);
                g("#search-value-after").val(B)
            } else {
                g("#search-value").val(y)
            }
        }
    }
    g.initializePageSearch = function(r) {
        c = r;
        h();
        o();
        g("#search-item").on("change", function(s) {
            a(s);
            b(s)
        });
        g("#search-condition").on("change", b);
        g("#button-add-condition").on("click", l);
        g("#button-addLibrary-condition").on("click", j);
        g("#conditions-wrap").on("click", ".word-selected", function(s) {
            q(s)
        });
        g("#search-value-wrap").on("keyup", "input", function(s) {
            if (s.keyCode == 13) {
                l()
            }
        });
        g("#conditions-wrap").on("click", ".word-del", d);
        g("#button-search-wrap").on("click", "a", e);
        g("#list-search-result-wrap").on("rowEdit.paginatedList cellClick.paginatedList", function(u, v) {
            var s = v.model;
            if (!s) {
                return
            }
            var t = ["/case"];
            if (s.PRD_CODE && s.SOURCE_TYPE && s.SOURCE_KEY && s.CASE_KEY) {
                t.push(s.PRD_CODE);
                t.push(s.SOURCE_TYPE);
                t.push(s.SOURCE_KEY);
                t.push(s.CASE_KEY)
            }
            if (t.length == 5) {
                document.getElementById("search-item").selectedIndex = -1;
                f();
                location.href = t.join("/").toLowerCase() + "-ae"
            }
        })
    }
})(jQuery);
(function(e) {
    var g = (function() {
        var i = new Date,
            k, h;
        try {
            (k = window.localStorage).setItem(i, i);
            h = k.getItem(i) == i;
            k.removeItem(i);
            return h && k
        } catch (j) {}
    }());

    function d(i, j, l) {
        var m = [i, "=", j];
        if (l) {
            var h = new Date(),
                k = l * 24 * 60 * 60 * 1000;
            h.setTime(h.getTime() + k);
            m.push("; expires=" + h.toGMTString())
        }
        window.document.cookie = m.join("")
    }

    function a(h) {
        var j = "(?:^|;)\\s*" + h + "=([^;]*)";
        var i = window.document.cookie.match(j);
        return (i) ? decodeURIComponent(i[1]) : null
    }

    function c(h) {
        d(h, "", -1)
    }

    function b(j) {
        var i;
        try {
            if (JSON && JSON.stringify) {
                i = JSON.stringify(j)
            } else {
                i = f(j)
            }
        } catch (h) {

            i = f(j)
        }
        return i
    }

    function f(n) {
        if (e.isArray(n)) {
            var o = ["["];
            for (var m = 0, l = n.length; m < l; m++) {
                o.push(f(n[m]))
            }
            o.push("]");
            return o.join("")
        } else {
            var k = [];
            for (var j in n) {
                var h = ['"', j, '":'];
                if (e.isNumeric(n[j])) {
                    h.push(n[j])
                } else {
                    h.push('"');
                    h.push((n[j] + "").replace(/"/, '"'));
                    h.push('"')
                }
                k.push(h.join(""))
            }
            return "{" + k.join(",") + "}"
        }
    }
    e.storagesavejson = function(h, j) {
        var i = b(j);
        if (g) {
            g.setItem(h, i)
        } else {
            d(h, i)
        }
    };
    e.storageloadjson = function(j, k, h) {
        var i;
        if (g) {
            i = g.getItem(j);
            if (k) {
                g.removeItem(j)
            }
        } else {
            i = a(j);
            if (k) {
                c(j)
            }
        }
        if (i) {
            return e.parseJSON(i)
        }
        if (h) {
            return h
        }
        return {}
    }
})(jQuery);
(function(d) {
    var f = document.initializerModel || {};
    var b = d("#area-sync-wrap"),
        h = true;
//    var g = {
//        //cdmsTable: "".concat('<table cellpadding="0" cellspacing="0" border="0" width="100%" class="test-table4" style="font-size: 12px;">', "<colgroup>", '<col width="7%" />', '<col width="" />', '<col width="20%" />', '<col width="20%" />', '<col width="20%" />', '<col width="15%" />', "</colgroup>", "<tbody style>", "<tr>", "<th>%{ALL_CHECKER}%</th>", "<th class=tleft></th>", "<th>" + f.sync["startDate"] + "</th>", "<th>" + f.sync["sae"] + "</th>", "<th>" + f.sync["followNum"] + "</th>", "<th>%{SELECTOR_LABEL}%</th>", "</tr>", "%{ROWS}%", "</tbody>", "</table>"),
//        cdmsTableRow: "".concat("<tr>", "%{HIDDEN_DATA}%", "<td>", "%{ROW_CHECKER}%", "</td>", '<td class="tleft">', "%{AE_NAME}%", "</td>", "<td>", "%{START_DATE}%", "</td>", "<td>", "%{IS_SAE}%", "</td>", "<td>", "%{FUNO}%", "</td>", "<td>", "%{TYPE_CHECKER}%", "</td>", "</tr>"),
//        //safetyTable: "".concat('<table cellpadding="0" cellspacing="0" border="0" width="100%" class="test-table4" style="font-size: 12px;">', "<colgroup>", '<col width="7%" />', '<col width="" />', '<col width="30%" />', '<col width="25%" />', "</colgroup>", "<tbody style>", "<tr>", "<th>%{ALL_CHECKER}%</th>", "<th class=tleft></th>", "<th>" + f.sync["startDate"] + "</th>", "<th>%{SELECTOR_LABEL}%</th>", "</tr>", "%{ROWS}%", "</tbody>", "</table>"),
//        safetyTableRow: "".concat("<tr>", "%{HIDDEN_DATA}%", "<td>", "%{ROW_CHECKER}%", "</td>", '<td class="tleft">', "%{AE_NAME}%", "</td>", "<td>", "%{START_DATE}%", "</td>", "<td>", "%{TYPE_CHECKER}%", "</td>", "</tr>"),
//        hidden: '<input type="hidden" name="%{NAME}%" value="%{VALUE}%" />',
//        cdmsAllChecker: '<input type="checkbox" class="cdms-all-checker" />',
//        cdmsRowChecker: '<input type="checkbox" class="cdms-checker" />',
//        cdmsTypeChecker: '<input type="radio" name="cdmsEventType" disabled />',
//        safetyRowChecker: '<input type="radio" name="safetyRowChecker" %{VALUE}% %{CHECKED}% />',
//        safetyTypeChecker: '<input type="checkbox" />',
//        noDataRow: '<tr><td colspan="4">' + f.auditTrailNoData + "</td></tr>",
//        //successResult: '<div class="layer-wrap1"><div class="layer-alarm1">' + f.sync["result.success"] + "</div></div>",
//        //failResult: '<div class="layer-wrap2"><div class="layer-alarm2">' + f.sync["result.fail"] + "</div></div>",
//        confirmWrap: "".concat('<div class="sync-result-wrap">', '<div class="sync-result">', "%{CONFIRM_TABLE}%", "%{BTN_WRAP}%", "</div>", "</div>"),
//        confirmTable: "".concat('<div class="sync-result-table">', '<table cellpadding="0" cellspacing="0" border="0" width="100%" class="test-table4">', "<colgroup>", '<col width="50%">', '<col width="50%">', "</colgroup>", "<tbody><tr>", "<th>" + f.sync["cubeCdms"] + "</th>", "<th>" + f.sync["cubeSafety"] + "</th>", "</tr>", "<tr>", "<td>", "%{CDMS_DATAS}%", "</td>", "<td>", "%{SAFETY_DATA}%", "</td>", "</tr>", "</tbody></table>", "</div>"),
//        confirmBtnWrap: "".concat('<div class="pt20 fwb">%{CONFIRM_MESSAGE}%</div>', '<div class="pt20">%{CONFIRM_BTNS}%</div>'),
//        confirmBtns: '<a href="#" class="alert-btn1">' + f.sync["button.yes"] + '</a> <a href="#" class="alert-btn2">' + f.sync["button.no"] + "</a>",
//        closeBtn: '<a href="#" class="alert-btn2" id="alert-btn-close">' + f.sync["button.close"] + "</a>"
//    };

    function a(k) {
        var j = b.find(".sync-left"),
            m = b.find(".sync-right"),
            l = k.data.model;
        j.on("click", ".btn-reset", function(n) {
            j.find("input:checkbox").prop("checked", false);
            e(false);
            if (m.find("input:radio:checked").val() == "new" || m.find("input:radio:checked").closest("tr").find("input:checkbox").is(":checked")) {
                e(true)
            }
        });
        j.on("change", "input:checkbox:not(.cdms-all-checker)", function(p) {
            var n = j.find("input:checkbox:not(.cdms-all-checker):checked").length,
                o = j.find("input:checkbox:not(.cdms-all-checker)").length;
            if (n == o) {
                j.find("input:checkbox.cdms-all-checker").prop("checked", true)
            } else {
                j.find("input:checkbox.cdms-all-checker").prop("checked", false)
            }
            if (m.find("input:radio:checked").val() == "new" || m.find("input:radio:checked").closest("tr").find("input:checkbox").is(":checked")) {
                if (d(p.target).is(":checked")) {
                    d(p.currentTarget).closest("tr").find("input:radio").removeAttr("disabled")
                } else {
                    d(p.currentTarget).closest("tr").find("input:radio").prop("disabled", true)
                }
                switch (n) {
                    case 0:
                        j.find("tr").find("input:radio").each(function(q, r) {
                            d(r).prop("checked", false)
                        });
                        break;
                    case 1:
                        if (d(p.currentTarget).is(":checked")) {
                            d(p.currentTarget).closest("tr").find("input:radio").prop("checked", true)
                        }
                        break;
                    default:
                        break
                }
            }
        });
        j.on("change", "input:checkbox.cdms-all-checker", function(n) {
            j.find("input:checkbox:not(.cdms-all-checker)").prop("checked", d(n.currentTarget).is(":checked"));
            j.find("input:radio").prop("disabled", !d(n.currentTarget).is(":checked"));
            if (d(n.currentTarget).is(":checked")) {
                if (j.find("input:checkbox:not(.cdms-all-checker):checked").length == 1) {
                    j.find("input:checkbox:not(.cdms-all-checker):checked").closest("tr").find("input:radio").prop("checked", true)
                }
            } else {
                j.find("input:radio").prop("checked", false)
            }
        });
        m.on("change", "input:checkbox", function(n) {
            if (d(n.currentTarget).closest("tr").find("input:radio").is(":checked")) {
                if (d(n.currentTarget).is(":checked")) {
                    e(true)
                } else {
                    e(false)
                }
            }
        });
        m.on("change", "input:radio", function(n) {
            var o = d(n.currentTarget).closest("tr").find("input:checkbox");
            if (d(n.currentTarget).val() == "new") {
                e(true)
            } else {
                m.find("input:checkbox").not(o).prop("checked", false);
                if (o.is(":checked")) {
                    e(true)
                } else {
                    e(false)
                }
            }
        });
        b.on("click", "#btn-sync", function(n) {
            var u = undefined,
                v = "",
                t = "";
            if (j.find("input:checkbox:not(.cdms-all-checker):checked").length > 0) {
                var p = m.find("input:radio:checked"),
                    s = true;
                if (p.val() != "new") {
                    s = p.closest("tr").find("input:checkbox").is(":checked")
                }
                if (s && j.find("input:radio:checked").length < 1) {
                    t = c(g.confirmBtnWrap, {
                        CONFIRM_MESSAGE: f.sync["empty.cdmsMain"] || 'Please Select "cubeCDMS Main".',
                        CONFIRM_BTNS: g.closeBtn
                    })
                } else {
                    var r = [],
                        o = [];
                    j.find("input:checkbox:not(.cdms-all-checker):checked").each(function(w, y) {
                        var x = [];
                        d(y).closest("tr").find("td").each(function(A, z) {
                            if (A == 1 || A == 2) {
                                x.push(d(z).text())
                            } else {
                                if (A == 5) {
                                    if (d(z).find("input:radio").is(":checked")) {
                                        x.push(f.sync["main"] || "Main")
                                    } else {
                                        x.push(f.sync["sub"] || "Sub")
                                    }
                                }
                            }
                        });
                        r.push(x.join(" / "))
                    });
                    var q = (m.find("input:radio:checked").val() == "new");
                    m.find("input:radio:checked").closest("tr").find("td").each(function(x, w) {
                        if (x == 1 || (x == 2 && !q)) {
                            o.push(d(w).text())
                        } else {
                            if (x == 3) {
                                if (d(w).find("input:checkbox").is(":checked")) {
                                    o.push(f.sync["followUp"] || "Follow Up")
                                }
                            }
                        }
                    });
                    v = c(g.confirmTable, {
                        CDMS_DATAS: r.join("<br />"),
                        SAFETY_DATA: o.join(" / ")
                    });
                    t = c(g.confirmBtnWrap, {
                        CONFIRM_MESSAGE: f.sync["confirm"] || "Are you sure you want to sync?",
                        CONFIRM_BTNS: g.confirmBtns
                    })
                }
            } else {
                t = c(g.confirmBtnWrap, {
                    CONFIRM_MESSAGE: f.sync["empty.cdmsAe"] || 'Please Select "cubeCDMS AE".',
                    CONFIRM_BTNS: g.closeBtn
                })
            }
            u = d(c(g.confirmWrap, {
                CONFIRM_TABLE: v,
                BTN_WRAP: t
            }));
            if (b.find(".sync-result-wrap").length > 0) {
                b.find(".sync-result-wrap").remove()
            }
            u.appendTo(b).position({
                of: d(".sync-btn"),
                my: "center bottom",
                at: "center bottom"
            })
        });
        b.on("click", "#btn-sync-cancel", function(o) {
            var n = d("#area-sync-wrap");
            n.slideUp(200);
            if (n.find(".sync-result-wrap").length > 0) {
                n.find(".sync-result-wrap").remove()
            }
        });
        b.on("click", ".alert-btn1", function(s) {
            var r = m.find("input:radio:checked"),
                o = null,
                t = false,
                u = l.STUDY_KEY,
                n = l.TEAM_KEY,
                q = l.SUBJ_KEY,
                p = l.REPORT_TYPE;
            if (r.val() != "new") {
                o = r.closest("tr").find('input[name="caseKey"]').val();
                t = r.closest("tr").find("input:checkbox").is(":checked")
            }
            d.ajax({
                type: "POST",
                url: k.baseUrl.concat("/sync-execute"),
                data: {
                    caseKey: o,
                    isFollow: t,
                    studyKey: u,
                    teamKey: n,
                    subjectKey: q,
                    reportType: p,
                    jsonString: i()
                },
                hideLoading: false,
                async: false,
                success: function(w) {
                    var v = undefined;
                    if (w.results.RESULT.toUpperCase() == "SUCCESS") {
                        d("#list-sync-wrap").paginatedList("refresh");
                        v = d(g.successResult)
                    } else {
                        v = d(g.failResult)
                    }
                    if (v != undefined) {
                        v.appendTo(".sync-result-wrap").position({
                            of: d(".sync-result-wrap .alert-btn1").closest("div"),
                            my: "center bottom",
                            at: "center top"
                        })
                    }
                    d(".sync-result-wrap .alert-btn1").remove();
                    d(".sync-result-wrap .alert-btn2").text("Close")
                },
                dataType: "json"
            })
        });
        b.on("click", ".alert-btn2", function(n) {
            if (d(n.currentTarget).text() == "Close" && d(n.currentTarget).attr("id") != "alert-btn-close") {
                d("#btn-sync-cancel").click()
            } else {
                d(".sync-result-wrap").remove()
            }
        })
    }

    function e(k) {
        var j = b.find(".sync-left");
        if (k) {
            j.find("input:checkbox:checked").closest("tr").find("input:radio").each(function(l, m) {
                d(m).removeAttr("disabled")
            });
            j.find("input:checkbox:checked:first").change()
        } else {
            j.find("tr").find("input:radio").each(function(l, m) {
                d(m).prop("checked", false);
                d(m).prop("disabled", true)
            })
        }
    }

    function i() {
        var k = b.find(".sync-left");
        if (k.find("input:checkbox:not(.cdms-all-checker):checked").length > 0) {
            var l = [];
            l.push('{"LNK_LIST":[');
            k.find("input:checkbox:not(.cdms-all-checker):checked").each(function(m, n) {
                if (m > 0) {
                    l.push(",")
                }
                l.push(j(m, n))
            });
            l.push("]}");
            return l.join("")
        } else {
            return ""
        }

        function j(n, r) {
            var q = d(r).closest("tr");
            var m = [];
            var o = "S";
            if (q.find("input:radio").is(":checked")) {
                o = "M"
            }
            m.push("{");
            m.push('"SCHD_KEY":'.concat(p("scheduleKey"), ","));
            m.push('"ROW_NP":'.concat(p("rowNp"), ","));
            m.push('"ROW_NO":'.concat(p("rowNo"), ","));
            m.push('"ITEM_KEY":'.concat(p("itemKey"), ","));
            m.push('"SAE_KEY":'.concat(p("saeKey"), ","));
            m.push('"SCHD_KEY_SAE":'.concat(p("scheduleKeySae"), ","));
            m.push('"FUNO":'.concat(p("funo"), ","));
            m.push('"EVENT_TYPE":"'.concat(o, '",'));
            m.push('"IS_SAE":"'.concat(p("isSae"), '"'));
            m.push("}");
            return m.join("");

            function p(s) {
                return q.find('input[name="'.concat(s, '"]')).val()
            }
        }
    }

    function c(k, j) {
        return k.replace(/%\{([A-Z0-9_]+)\}%/gi, function() {
            var l = arguments[1];
            if (j[l] !== undefined) {
                if (d.isArray(j[l])) {
                    return j[l].join("")
                }
                return j[l]
            }
            return ""
        })
    }
    d.adjustSubjectSync = function(l) {
        var n = l.data.model.SUBJ_ID,
            m = l.data.model.SUBJ_KEY,
            p = [],
            k = [],
            q = [],
            j = [];
        b.find(".sync-subject").text(n);
        d.ajax({
            type: "POST",
            url: l.baseUrl.concat("/sync-ae-list"),
            data: {
                subjectId: n,
                subjectKey: m
            },
            hideLoading: true,
            async: false,
            success: function(r) {
                k = r.cdmsAEList;
                j = r.safetyAEList
            },
            dataType: "json"
        });
        if (k.length > 0) {
            d.each(k, function(s, u) {
                var r = [];
                for (var t in u) {
                    r.push(c(g.hidden, {
                        NAME: t,
                        VALUE: u[t]
                    }))
                }
                p.push(c(g.cdmsTableRow, {
                    HIDDEN_DATA: r.join(""),
                    ROW_CHECKER: g.cdmsRowChecker,
                    AE_NAME: o(u.aeName),
                    IS_SAE: o(u.isSae),
                    FUNO: o(u.funo),
                    START_DATE: o(u.aeBeginDate),
                    TYPE_CHECKER: g.cdmsTypeChecker
                }))
            })
        } else {
            p.push(g.noDataRow)
        }
        b.find(".sync-left").find(".sync-table-wrap").html(c(g.cdmsTable, {
            ALL_CHECKER: g.cdmsAllChecker,
            ROWS: p.join(""),
            SELECTOR_LABEL: f.sync["main"] || "Main"
        }));
        q.push(c(g.safetyTableRow, {
            ROW_CHECKER: c(g.safetyRowChecker, {
                CHECKED: "checked",
                VALUE: 'value="new"'
            }),
            AE_NAME: f.sync["newCase"] || "New Case"
        }));
        d.each(j, function(s, t) {
            var r = [];
            r.push(c(g.hidden, {
                NAME: "caseKey",
                VALUE: t.caseKey
            }));
            q.push(c(g.safetyTableRow, {
                HIDDEN_DATA: r.join(""),
                ROW_CHECKER: c(g.safetyRowChecker, {
                    CHECKED: "",
                    VALUE: ""
                }),
                AE_NAME: o(t.aeName),
                START_DATE: o(t.aeBeginDate),
                TYPE_CHECKER: g.safetyTypeChecker
            }))
        });
        b.find(".sync-right").find(".sync-table-wrap").html(c(g.safetyTable, {
            ALL_CHECKER: "&nbsp;",
            ROWS: q.join(""),
            SELECTOR_LABEL: f.sync["followUp"] || "Follow up"
        }));
        if (h) {
            h = false;
            a(l)
        }
        if (b.css("display") == "none") {
            b.slideDown(200)
        }

        function o(r) {
            if (r === undefined || r === null) {
                return ""
            }
            return r
        }
    };
    d.registAllSync = function(k) {
        d(document.body).on("click", "#btn-all-sync", function(n) {
            var l = d('<table cellpadding="0" cellspacing="0" border="0" width="100%" class="layer-table1"><tbody><tr><th><strong>' + f.sync["allSync.confirm"] + "</strong></th></tr></tbody></table>"),
                m = {};
            m["All Sync"] = function() {
                j(k);
                d.popoverdialog("close");
                return false
            };
            m.Cancel = function() {
                d.popoverdialog("close")
            };
            d("#btn-all-sync").popoverdialog({
                title: f.sync["allSync.title"] || "Confirm of All Sync",
                width: 300,
                content: l,
                buttons: m
            })
        });

        function j(l) {
            d.ajax({
                type: "POST",
                url: l.concat("/all-sync-execute"),
                data: {},
                hideLoading: false,
                async: false,
                success: function(n) {
                    var m = "Success Count :" + n.results.COUNT;
                    d("#list-sync-wrap").paginatedList("refresh");
                    d("#btn-all-sync").noticepopup(m)
                },
                dataType: "json"
            })
        }
    };
    d(document.body).on("click", "#home-case-sync tbody tr", function(k) {
        var l = d(k.currentTarget),
            j = l.attr("data-url");
        if (!j) {
            return false
        }
        m(function() {
            location.href = j
        });
        return false;

        function m(o) {
            var n = [{
                name: "property",
                value: "SOURCE_SYNC"
            }, {
                name: "column",
                value: "SAE_STATUS"
            }, {
                name: "code",
                value: "Y"
            }];
            d.ajax({
                type: "POST",
                url: "/paginated/filtering.json",
                data: n,
                hideLoading: true,
                success: function(p) {
                    n = [{
                        name: "property",
                        value: "SOURCE_SYNC"
                    }, {
                        name: "column",
                        value: "CHK_SAVE"
                    }, {
                        name: "code",
                        value: "N"
                    }];
                    d.ajax({
                        type: "POST",
                        url: "/paginated/filtering.json",
                        data: n,
                        hideLoading: true,
                        success: function(q) {
                            o.call(this)
                        },
                        dataType: "json"
                    })
                },
                dataType: "json"
            })
        }
    })
})(jQuery);