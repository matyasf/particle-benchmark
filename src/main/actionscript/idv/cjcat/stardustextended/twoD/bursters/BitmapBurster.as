package idv.cjcat.stardustextended.twoD.bursters {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Matrix;

    import idv.cjcat.stardustextended.common.particles.Particle;
	import idv.cjcat.stardustextended.twoD.particles.Particle2D;
	
	/**
	 * Bursts out particles with <code>target</code> properties being references to small rectangular fractions (cells) of a bitmap.
	 * 
	 * <p>
	 * Initially, these particles are positioned as a two-by-two array, 
	 * and stick tightly together to each other, 
	 * forming a complete bitmap as a whole.
	 * </p>
	 * 
	 * <p>
	 * Adding any iniitalizers that set the <code>target</code> property essentially does nothing, 
	 * since this burster internally sets particles' targets to <code>Bitmap</code> objects.
	 * </p>
	 */
	public class BitmapBurster extends Burster2D {
		
		/**
		 * The width of a cell.
		 */
		public var cellWidth:int;
		/**
		 * The height of a cell.
		 */
		public var cellHeight:int;
		/**
		 * The X coordinate of the top-left corner of the top-left cell.
		 */
		public var offsetX:Number;
		/**
		 * The Y coordinate of the top-left corner of the top-left cell.
		 */
		public var offsetY:Number;
		
		public var bitmapData:BitmapData;
		
		public function BitmapBurster(cellWidth:int = 10, cellHeight:int = 10, offsetX:Number = 0, offsetY:Number = 0) {
			this.cellWidth = cellWidth;
			this.cellHeight = cellHeight;
			this.offsetX = offsetX;
			this.offsetY = offsetY;
		}
		
		override public function createParticles(currentTime : Number):Vector.<Particle> {
			if (!bitmapData) return null;
			
			var rows:int = Math.ceil(bitmapData.height / cellHeight);
			var columns:int = Math.ceil(bitmapData.width / cellWidth);
			var particles:Vector.<Particle> = factory.createParticles(rows * columns, currentTime);
			
			var index:int = 0;
			var matrix:Matrix = new Matrix();
			var halfCellWidth:Number = 0.5 * cellWidth;
			var halfCellHeight:Number = 0.5 * cellHeight;
			var p:Particle2D;

			for (var j:int = 0; j < rows; j++) {
				for (var i:int = 0; i < columns; i++) {
					var cellBMPD:BitmapData = new BitmapData(cellWidth, cellHeight, true, 0);
					matrix.tx = -cellWidth * i;
					matrix.ty = -cellHeight * j;
					cellBMPD.draw(bitmapData, matrix);
					var cell:Bitmap = new Bitmap(cellBMPD);
					cell.x = -halfCellWidth;
					cell.y = -halfCellHeight;
					var sprite:Sprite = new Sprite();
					sprite.addChild(cell);
					
					p = Particle2D(particles[index]);
					p.target = sprite;
					p.x = sprite.x = halfCellWidth + cellWidth * i + offsetX;
					p.y = sprite.y = halfCellHeight + cellHeight * j + offsetY;
				}
			}
			
			return particles;
		}
	}
}