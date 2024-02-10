import { Injectable } from '@nestjs/common';
import { Praise } from 'src/entities/Praise';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { User } from 'src/entities/User';
import { Comment } from 'src/entities/Comment';
import { Stamp } from 'src/entities/Stamp';

@Injectable()
export class PraiseService {
  constructor(
    @InjectRepository(Praise)
    private readonly praiseRepository: Repository<Praise>,
    @InjectRepository(User)
    private readonly userRepository: Repository<User>,
    @InjectRepository(Comment)
    private readonly commentRepository: Repository<Comment>,
    @InjectRepository(Stamp)
    private readonly stampRepository: Repository<Stamp>,
  ) {}

  async postPraise(body: {
    description: string;
    from_user_id: number;
    to_user_id: number;
  }): Promise<Praise> {
    const praise = new Praise();
    praise.description = body.description;
    praise.fromUser = await this.userRepository.findOneByOrFail({
      id: body.from_user_id,
    });
    praise.toUser = await this.userRepository.findOneByOrFail({
      id: body.to_user_id,
    });
    return await this.praiseRepository.save(praise);
  }

  async getCurrentPraise(): Promise<Praise> {
    return await this.praiseRepository.findOneOrFail({
      order: { id: 'DESC' },
    });
  }

  async findById(id: number): Promise<Praise | null> {
    return await this.praiseRepository.findOneBy({ id });
  }

  async putComment(
    praise_id: Praise['id'],
    comment: {
      from_user_id: number;
      comment: string;
    },
  ): Promise<Comment> {
    const praise = await this.praiseRepository.findOneByOrFail({
      id: praise_id,
    });
    const fromUser = await this.userRepository.findOneByOrFail({
      id: comment.from_user_id,
    });
    const existComment = await this.commentRepository.findOneBy({
      praise,
      fromUser,
    });
    if (existComment != null) {
      existComment.comment = comment.comment;
      return await this.commentRepository.save(existComment);
    }
    const newComment = new Comment();
    newComment.comment = comment.comment;
    newComment.praise = praise;
    newComment.fromUser = fromUser;

    return await this.commentRepository.save(newComment);
  }

  async putStamp(
    praise_id: Praise['id'],
    stamp: {
      from_user_id: number;
      stamp: string;
    },
  ): Promise<Stamp> {
    const praise = await this.praiseRepository.findOneByOrFail({
      id: praise_id,
    });
    const fromUser = await this.userRepository.findOneByOrFail({
      id: stamp.from_user_id,
    });
    const newStamp = new Stamp();
    newStamp.stamp = stamp.stamp;
    newStamp.praise = praise;
    newStamp.fromUser = fromUser;

    return await this.stampRepository.save(newStamp);
  }
}
