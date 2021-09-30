import { csrfToken } from "@rails/ujs";
import { Controller } from "stimulus"
import Sortable from "sortablejs"

export default class extends Controller {
  connect() {
    this.sortable = Sortable.create(this.element, {
      onEnd: this.end.bind(this),
      group: {
        name: "item",
        pull: true,
        put: true
      }
    })
  }

  end(event){
    let itemId = event.item.dataset.itemId
    // let taskId = event.to.children[0].dataset.taskId
    let taskId = event.to.children[0].dataset.taskId
    // let data = new FormData()
    console.log('item' + itemId)
    console.log('task' + taskId)
    // console.log(data)
    // console.log(event.newIndex)
    // console.log(this.data.url)
    // data.append("position", event.newIndex + 1)
    // data.append("task_id", taskId )
    // fetch(this.data.get("url").replace(":id", itemId), {
    //   method: 'PATCH',
    //   headers: { 'X-CSRF-Token': csrfToken() },
    //   body: data
    // })
    // .then(res => console.log(res))
  }
}
