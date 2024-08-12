
/***************Post**************************/



/**************************icons+text change **************************/
//change the icon when the user click on it

//love btn


//save btn
let save_icon = document.querySelectorAll(".save");
save_icon.forEach(function (save) {
  save.addEventListener("click", function () {
    let not_save = save.children[1];
    let saved = save.children[0];
    not_save.classList.toggle("hide");
    saved.classList.toggle("hide");

  })
})

//notification follow 
let not_follow = document.querySelectorAll("#notification .notif.follow_notif")
not_follow.forEach(item => {
  let follow = item.children[0].children[1].children[0];
  follow.addEventListener("click", function (e) {
    e.stopPropagation();
    follow.classList.toggle("following");
    if (follow.classList.contains("following")) {
      follow.innerHTML = "Following";
      follow.style.backgroundColor = 'rgb(142, 142, 142)';
      follow.style.color = "black";
    } else {
      follow.innerHTML = "Follow";
      follow.style.backgroundColor = 'rgb(0, 149, 246)';
      follow.style.color = "white";
    }

  });
})

/**************************comments **************************/

//comments
let replay_com = document.querySelector(".comments .responses");
let show_replay = document.querySelector(".comments .see_comment");
let hide_com = document.querySelector(".comments .see_comment .hide_com");
let show_com = document.querySelector(".comments .see_comment .show_c");
if (replay_com) {
  replay_com.classList.add("hide");
  hide_com.classList.add("hide");
  show_replay.addEventListener("click", function () {
    replay_com.classList.toggle("hide");
    show_com.classList.toggle("hide");
    hide_com.classList.toggle("hide");
  });
}


/*************emojie*************** */
$(document).ready(function () {
  $("#emoji").emojioneArea({
    pickerPosition: "top",
    tonesStyle: "radio"
  });
});

$(document).ready(function () {
  $("#emoji_create").emojioneArea({
    pickerPosition: "bottom",
    tonesStyle: "radio"
  });
});

$(document).ready(function () {
  $("#emoji_comment").emojioneArea({
    pickerPosition: "bottom",
    tonesStyle: "radio"
  });
});

/**********Upload post*************/
const form = document.getElementById('upload-form');
const img_container = document.querySelector("#image-container");

form.addEventListener('change', handleSubmit);

let img_url;
//add the image post
function handleSubmit(event) {
  event.preventDefault();
  if (img_container.classList.contains('hide_img')) {
    img_container.classList.remove('hide_img');
    const imageFile = document.getElementById('image-upload').files[0];
    const imageURL = URL.createObjectURL(imageFile);
    const image = document.createElement('img');
    image.src = imageURL;
    img_url = imageURL;
    const imageContainer = document.getElementById('image-container');
    imageContainer.appendChild(image);
    const next_btn_post = document.querySelector(".next_btn_post");
    const title_create = document.querySelector(".title_create");
    next_btn_post.innerHTML = 'Next';
    title_create.innerHTML = 'Crop';
  }
}

/////button submit
const next_btn_post = document.querySelector(".next_btn_post");
next_btn_post.addEventListener('click', handleNext);
//add a description + click btn to share post
function handleNext() {
  if (image_description.classList.contains('hide_img')) {
    const next_btn_post = document.querySelector(".next_btn_post");
    const title_create = document.querySelector(".title_create");
    const image_description = document.querySelector("#image_description");
    const modal_dialog = document.querySelector("#create_modal .modal-dialog");
    modal_dialog.classList.add("modal_share");
    image_description.classList.remove('hide_img')
    const image = document.createElement('img');
    image.src = img_url;
    const img_p = document.querySelector('.img_p');
    img_p.appendChild(image);
    next_btn_post.classList.add("share_btn_post");
    next_btn_post.classList.remove("next_btn_post");
    next_btn_post.innerHTML = 'Share';
    title_create.innerHTML = 'Create new post';
    completed();
  }
}

//post published
function completed() {
  const share_btn_post = document.querySelector(".share_btn_post");
  const post_published = document.querySelector('.post_published');
  const modal_dialog = document.querySelector("#create_modal .modal-dialog");
  share_btn_post.addEventListener("click", function () {
    modal_dialog.classList.add("modal_complete");
    post_published.classList.remove("hide_img");
    share_btn_post.innerHTML = ""
  })
}




