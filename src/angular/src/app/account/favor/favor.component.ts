import { Component, OnInit, ViewChild, Input } from '@angular/core';
import { ApiService, OembedService } from '../../service'
import { Video } from 'src/app/model';
import { DomSanitizer } from '@angular/platform-browser';
import { ToastrService } from 'ngx-toastr';
import { NgxSmartModalService } from 'ngx-smart-modal';
import { AccountService } from '../account.service';
import { ActivatedRoute } from '@angular/router';


@Component({
  selector: 'app-favor',
  templateUrl: './favor.component.html',
  styleUrls: ['./favor.component.scss']
})
export class FavorComponent implements OnInit {

  constructor(private api: ApiService, public domSanitizer: DomSanitizer,
              private toastr: ToastrService, public modal: NgxSmartModalService, private account: AccountService,
              private route: ActivatedRoute) {

  }


  items: Array<Video> = new Array<Video>();
  video: Video = new Video();

// tslint:disable-next-line: variable-name
  selected_mark: number;
  @Input()
  uid: number;


  errorLambda: any = error => {
    if (error.status > 0) {
      this.toastr.error(error.error);
    } else {
      this.toastr.error('Connection error!');
    }
  }

  repairLink(link) {
    return link.replace(/\/watch\?v=(.{11})/, '/embed/$1');
  }


  updateFavors() {
    this.items = [];

    this.api.get('favourite', this.uid).subscribe(
      data => {
        // tslint:disable-next-line: forin
        for (const id in data) {
          const favor = data[id];
          const video: Video = favor;

          // Block of link repairing
          video.link = this.domSanitizer.bypassSecurityTrustResourceUrl(this.repairLink(video.link));

          this.items.push(video);
        }
      },
      this.errorLambda
    );
  }

  createFavor() {
    let id: number;
    // Post video
    this.api.post('video', this.video).subscribe(
      next =>  {
        this.modal.getModal('modalAddItem').close();
        // this.toastr.success('Video successfully added!');
        // this.updateFavors();
        id = (next as any).id;
        console.log(id);
        this.updateVote(id, this.video.mark);
      },
      this.errorLambda
    );
    // Update vote (not seem to apper with favourite - join video and mark)
  }

  updateVote(id: number, mark: number) {
    console.log(mark);

    this.api.putDoubleId('vote', id, mark).subscribe(
      () => this.toastr.success("Mark changed") && this.updateFavors(),
      this.errorLambda
    );
  }

// tslint:disable-next-line: variable-name
  deleteFavor(video_id: number) {
    this.api.delete('item', video_id).subscribe(
      () => this.toastr.success("Video deleted") && this.updateFavors(),
      this.errorLambda
    );
    this.updateFavors();
  }

ngOnInit() {
    this.route.paramMap.subscribe(params => {
      let uid = params.get('uid') as any;
      if(uid == null){
        this.uid = this.account.id;
      }
      else{
        this.uid = uid as number;
      }
    });

    this.updateFavors();
}

}
