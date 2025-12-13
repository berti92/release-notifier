import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    showTab(event) {
        console.log(event.target);
        let liElement = event.target.closest('li');
        let ulElement = liElement.parentElement;
        ulElement.querySelectorAll('li').forEach(element => {
            if(element.classList.contains('is-active')) {
                element.classList.remove('is-active');
            }
            document.getElementById(element.dataset.id).style.display = 'none';
        });
        document.getElementById(liElement.dataset.id).style.display = 'block';
        liElement.classList.add('is-active');
    }
    showHideRepoField(event) {
        let repoElement = document.getElementById('repo_text_field_div');
        if (event.target.value == 'github') {
            repoElement.style.display = 'block';
            if (document.getElementById('notification_repo').value == 'wrong_repo/format') {
                document.getElementById('notification_repo').value = '';
            }
        } else {
            repoElement.style.display = 'none';
            document.getElementById('notification_repo').value = 'wrong_repo/format';
        }
    }
}