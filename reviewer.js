/* http://www.whatwg.org/specs/web-apps/current-work/reviewer.js */

function getCookie(name) {
 var params = location.search.substr(1).split("&");
 for (var index = 0; index < params.length; index++) {
   if (params[index] == name)
     return "1";
   var data = params[index].split("=");
   if (data[0] == name)
     return unescape(data[1]);
 }
 var cookies = document.cookie.split("; ");
 for (var index = 0; index < cookies.length; index++) {
   var data = cookies[index].split("=");
   if (data[0] == name)
     return unescape(data[1]);
 }
 return null;
}

var currentAlert;
var currentAlertTimeout;
function showAlert(s, href) {
 if (!currentAlert) {
   currentAlert = document.createElement('div');
   currentAlert.id = 'alert';
   var x = document.createElement('button');
   x.textContent = 'Close';
   x.onclick = closeAlert2;
   currentAlert.appendChild(x);
   currentAlert.appendChild(document.createElement('span'));
   currentAlert.onmousemove = function () {
     clearTimeout(currentAlertTimeout);
     currentAlert.className = '';
     currentAlertTimeout = setTimeout(closeAlert, 10000);
   }
   document.body.appendChild(currentAlert);
 } else {
   clearTimeout(currentAlertTimeout);
   currentAlert.className = '';
 }
 currentAlert.lastChild.textContent = s + ' ';
 if (href) {
   var link = document.createElement('a');
   link.href = href;
   link.textContent = href;
   currentAlert.lastChild.appendChild(link);
 }
 currentAlertTimeout = setTimeout(closeAlert, 10000);
}
function closeAlert() {
 currentAlert.className = 'closed';
 currentAlertTimeout = setTimeout(closeAlert2, 3000);
}
function closeAlert2() {
 currentAlert.parentNode.removeChild(currentAlert);
 currentAlert = null;
 clearTimeout(currentAlertTimeout);
}

var reviewer;
var reviewSectionId;

function setReviewMode(mode) {
  var date = new Date();
  date.setFullYear(date.getFullYear() + 1);
  document.cookie = 'review=' + encodeURIComponent(mode) + '; expires=' + date.toGMTString() + '; path=/';
  reviewer.className = mode;
  if (mode == 'off')
    document.getElementById('reviewShowHide').value = '\u2B05';
  else
    document.getElementById('reviewShowHide').value = '\u27A1';
}

function showReviewHelp() {
  alert('Select a section by clicking it, then enter a message in the box and press the "Submit Review Comment" button. This will cause your comment to be filed, along with your IP address, in the issue tracker, where it will be reviewed and eventually addressed. You won\'t get a reply, though.');
}

function toggleReviewMode() {
  setReviewMode(reviewer.className == 'off' ? 'on' : 'off');
}

function submitReviewComment(textField, button) {
  var text = document.getElementById('reviewCommentText').value;
  if ((!reviewSectionId) || (reviewSectionId == 'reviewCommentText')) {
    showAlert('Please select a section by clicking on it, and then submit the comment again.');
  } else if (!text) {
    showAlert('Please enter a description of the problem you have found, and then submit the comment again.');
  } else if ((text.length <= 5) || (text.indexOf(' ') < 0)) {
    showAlert('Please ensure that your comment is descriptive enough that the editor can understand it.');
  } else {
    var x = new XMLHttpRequest();
    x.open('POST', '/file-bug.cgi');
    x.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    x.onreadystatechange = function () {
      if (x.readyState == 4) {
        if (x.status == 200 && x.responseText != 'ERROR') {
          showAlert('Thank you for helping document Ruby! Your comment was filed as issue ' + x.responseText + '. You can see it at:', 'XXXXX' + x.responseText);
          textField.value = '';
        } else {
          showAlert('An error occured while submitting your comment. Please submit it manually.');
        }
        button.disabled = false;
        textField.select();
      }
    };
    var git_hash = document.getElementsByTagName('section')[0].id;
    var page = window.location.pathname.substr(1);
    x.send('id=' + encodeURIComponent(reviewSectionId) + '&text=' + encodeURIComponent(text) + '&git=' + git_hash + "&page=" + page);
    button.disabled = true;
  }
}

function reviewSectionSelectByClick(event) {
  var section = event.target;
  while (section && (!section.id || section.className.match(/\bpanel\b/ || section.tagName == 'INPUT'))) {
    if (section.previousSibling)
      section = section.previousSibling;
    else
      section = section.parentNode;
  }
  if (section && section.id && section != reviewer && section.id != 'alert')
    reviewSectionSelect(section.id)
}

function reviewSectionSelectByHash(event) {
  if (location.hash.length > 1)
    reviewSectionSelect(location.hash.substr(1));
}

function reviewSectionSelect(s) {
  document.getElementById('reviewSection').textContent = 'Section "' + s + '" selected. Comment:';
  reviewSectionId = s;
}

function initReviewer() {
  reviewer = document.createElement('div');
  reviewer.id = 'reviewer';
  reviewer.onclick = function (event) { event.stopPropagation() };
  reviewer.innerHTML = '<input value="" id="reviewShowHide" type=button onclick=toggleReviewMode()> <span id="reviewSection">Click the location of the error to select it, then type your message here:</span> <input size=60 id=reviewCommentText onkeydown="if (event.keyCode == 13) { submitReviewComment(this, this.nextSibling.nextSibling) }"> <input value="Comment" type=button onclick="submitReviewComment(this.previousSibling.previousSibling, this)"> <input value="Help" type=button onclick=showReviewHelp()>';
  document.body.appendChild(reviewer);
  var mode = getCookie('review');
  if (mode != 'off')
    mode = 'on';
  setReviewMode(mode);
}

$(document).ready(function() {
  initReviewer();
  if (!window.showAlert)
    showAlert = alert;
  window.addEventListener('hashchange', reviewSectionSelectByHash, false);
  document.addEventListener('click', reviewSectionSelectByClick, false);
});
