import { Injectable } from '@nestjs/common';
import { Comment } from 'src/models/comment/comment';
import { Praise } from 'src/models/praise/praise';
import { Stamp } from 'src/models/stamp/stamp';

@Injectable()
export class PraiseService {
  constructor() {}
  private readonly praises: Praise[] = [];

  async postPraise(
    body: Omit<Praise, 'id' | 'comments' | 'stamps'>,
  ): Promise<Praise> {
    const praise = new Praise();
    praise.id = this.praises.length + 1;
    praise.title = body.title;
    praise.description = body.description;
    praise.from_user_id = body.from_user_id;
    praise.to_user_id = body.to_user_id;
    praise.comments = [];
    praise.stamps = [];
    this.praises.push(praise);
    return praise;
  }

  async getCurrentPraise(): Promise<Praise | undefined> {
    return this.praises[this.praises.length - 1];
  }

  async findById(id: number): Promise<Praise | undefined> {
    return this.praises.find((praise) => praise.id === id);
  }

  async putComment(
    praise: Praise,
    comment: Omit<Comment, 'id'>,
  ): Promise<Comment> {
    const existComment = praise.comments.find(
      (item) => item.from_user_id === comment.from_user_id,
    );
    if (existComment != null) {
      existComment.comment = comment.comment;
      return existComment;
    }
    const newComment = new Comment();
    newComment.id = praise.comments.length + 1;
    newComment.comment = comment.comment;
    newComment.from_user_id = comment.from_user_id;

    praise.comments.push(newComment);

    return newComment;
  }

  async putStamp(praise: Praise, stamp: Omit<Stamp, 'id'>): Promise<Stamp> {
    const existStamp = praise.stamps.find(
      (item) => item.from_user_id === stamp.from_user_id,
    );
    if (existStamp != null) {
      existStamp.stamp = stamp.stamp;
      return existStamp;
    }
    const newStamp = new Stamp();
    newStamp.id = praise.stamps.length + 1;
    newStamp.stamp = stamp.stamp;
    newStamp.from_user_id = stamp.from_user_id;

    praise.stamps.push(newStamp);

    return newStamp;
  }
}
